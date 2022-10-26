import os
import json
from typing import List
from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm.session import Session
from sqlalchemy.sql.elements import and_, between, or_
from db import database
from routers.plantillas import templates
from datetime import date, datetime
from fastapi.responses import FileResponse



def prepParam(sqlParams, parentesisOpen, campoTbl, comparacion, valor, parentesisCloseAndOr):
    """"Preparar parámetro para consulta sql"""
    cond = ""
    if (valor):
        campoTblLimpio = campoTbl.replace(".","_")
        cond = f"{parentesisOpen} {campoTbl} {comparacion} :{campoTblLimpio} {parentesisCloseAndOr} "
        if (comparacion=="like"):
            ca,sa = 'áéíóúüñÁÉÍÓÚÜÑ','aeiouunAEIOUUN'
            valorlike = str.maketrans(ca,sa)

            cond = f"{parentesisOpen} {campoTbl} LIKE :{campoTblLimpio} {parentesisCloseAndOr} "
            sqlParams[campoTblLimpio] = f'%{valor.translate(valorlike)}%'
        elif (comparacion=="start"):
            ca,sa = 'áéíóúüñÁÉÍÓÚÜÑ','aeiouunAEIOUUN'
            valorlike = str.maketrans(ca,sa)
            cond = f"{parentesisOpen} {campoTbl} LIKE :{campoTblLimpio} {parentesisCloseAndOr} "
            sqlParams[campoTblLimpio] = f'{valor.translate(valorlike)}%'
        else:
            sqlParams[campoTblLimpio] = valor
    return cond

def prepParamBetween(sqlParams, parentesisOpen, campoTbl, valorIni, valorFin, parentesisCloseAndOr):
    """"Preparar parámetro para consulta sql con between"""
    cond = ""
    if (valorIni and valorFin):
        campoTblLimpio = campoTbl.replace(".","_")
        cond = f"{parentesisOpen}{campoTbl} between :{campoTblLimpio}valIni and :{campoTblLimpio}valFin {parentesisCloseAndOr} "
        sqlParams[f'{campoTblLimpio}valIni'] = valorIni
        sqlParams[f'{campoTblLimpio}valFin'] = valorFin
    return cond