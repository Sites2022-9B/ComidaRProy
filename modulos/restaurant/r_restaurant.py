from fastapi.encoders import jsonable_encoder
from fastapi import APIRouter, Depends, HTTPException, FastAPI, Request, Response
from db import database
from sqlalchemy.orm import Session
from modulos.restaurant.models import Restaurant, Platillos
from modulos.restaurant.schema import PlatilloAdd
from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import sessionmaker
from db.base_class import Base
from modulos.shared_def import prepParam, prepParamBetween

router = APIRouter(tags=['Restaurant'])

@router.get("/api/pedidosres")
async def pedido_restaurant(rest_id:str, response: Response, db: Session = Depends(database.get_db)):
    print("pedidos")
    sql = f'''
        SELECT plat.id_pedido,plat.id_restaurant, plat.status, plat.total, GROUP_CONCAT(pl.nombre) nombre FROM (
            SELECT env.*, pepl.id_platillo FROM(
                SELECT id_pedido, id_restaurant, status, total FROM envios WHERE id_restaurant = {rest_id})env
                LEFT JOIN restaurant res ON res.id = env.id_restaurant
                LEFT JOIN pedido_platillos pepl ON pepl.id_pedido = env.id_pedido)plat
            LEFT JOIN platillos pl ON pl.id = plat.id_platillo
                '''        
    sqlParams = {}
    # cond += prepParam(sqlParams, '', 'proy_id', '=', proy_id, 'and')
    print(sql)
    # Obtener la página de registros derivados de la consulta
    metadata = database.execSql(sql, sqlParams, True)
    print(metadata)
    # labels= ProyMeta().getLabels(database)
    return jsonable_encoder(metadata)

@router.get("/api/platillosres")
async def platillos_restaurant(rest_id:str, busq: str, vmin:str, vmax:str, cat:str, response: Response, db: Session = Depends(database.get_db)):
    print("platillos")
    sql = f'''
        Select pl.id, pl.id_restaurant, pl.nombre, pl.descripcion,
         pl.precio, pl.imagen, pl.categoria, pl.status From(SELECT * FROM platillos WHERE id_restaurant = {rest_id} )pl
                '''
    cond = ''        
    sqlParams = {}
    cond += prepParam(sqlParams, '(', 'pl.nombre', 'like', busq, 'OR')
    cond += prepParam(sqlParams, '', 'pl.descripcion', 'like', busq, ') AND')
    cond += prepParam(sqlParams, '', 'pl.categoria', 'like', cat, 'AND')
    cond += prepParamBetween(sqlParams, '', 'pl.precio', vmin, vmax, '')
    if ( len(cond)>0 ) : sql = f"{sql} where {cond}"
    metadata = database.execSqlprueba(sql, sqlParams, True)
    return jsonable_encoder(metadata)

@router.get("/api/res/platillos/preciomax")
async def platillos_preciomax(rest_id:str, response: Response, db: Session = Depends(database.get_db)):
    print("precio maximo de platillos restaurant")
    sql = f'''
        SELECT Max(precio) precio FROM platillos WHERE id_restaurant = {rest_id}
                '''        
    sqlParams = {}
    # cond += prepParam(sqlParams, '', 'proy_id', '=', proy_id, 'and')
    print(sql)
    # Obtener la página de registros derivados de la consulta
    metadata = database.execSql(sql, sqlParams, True)
    print("precio max ", metadata)
    return jsonable_encoder(metadata[0])

@router.post("/api/res/platillos/add")
async def platillos_preciomax(platilloDado:PlatilloAdd, response: Response, db: Session = Depends(database.get_db)):
    print("Agregando platillo")
    print(platilloDado)
    existe_pl = db.query(Platillos).filter(Platillos.nombre == platilloDado.nombre, Platillos.descripcion == platilloDado.descripcion).first()
    print("Existe? ",existe_pl)
    if existe_pl == None:
            datos = Platillos(
                id_restaurant = platilloDado.api_token,
                nombre = platilloDado.nombre,
                descripcion = platilloDado.descripcion,
                precio = platilloDado.precio,
                imagen = "",
                categoria = platilloDado.categoria,
                status = "disponible"
            )
            datos.create(db)
            return {"message": "Success!!!"}
    raiseExceptionDataErr(f"El lugar ya existe, favor de verificar")