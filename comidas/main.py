from typing import Tuple
from db.database import createLastChangesInDB
from sqlalchemy.orm import Session
from db import database
from routers.plantillas import templates
from fastapi import FastAPI, Request, Depends
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse
from starlette.responses import RedirectResponse
from starlette.exceptions import HTTPException
from fastapi.encoders import jsonable_encoder
from modulos.seguridad.r_authentication import SessionData, test_session
from modulos.seguridad import initBDSeguridad, r_authentication
# from modulos.restaurant import r_restaurant

# Cargar en memoria todos los modelos para su creación automática
from modulos.seguridad.models import *

# Crear las tablas en BD según los modelos previamente cargados
#Base.metadata.create_all(engine)

# Ejecutar los archivos de scritps de sql de cambios sobre estructuras y datos de la base de datos
if not createLastChangesInDB():
    print('Se presentaron errores de conexión con el servidor de base de datos y con los scripts de actualizaciones')
else:
    # Inicializar estructuras y datos del modulo de seguridad
    initBDSeguridad.initBDdatos()

app = FastAPI( title="Comidas")

app.mount("/static", StaticFiles(directory="static"), name="static")

app.include_router(r_authentication.router)



HOST="127.0.0.1"
PORT=8000
print (f"Presiona CTRL + click en: http://{HOST}:{PORT}")
if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host=HOST, port=PORT)
