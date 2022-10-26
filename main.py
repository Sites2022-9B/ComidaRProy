from db.database import createLastChangesInDB
from routers.plantillas import templates
from fastapi import FastAPI, Request, Depends
from fastapi.staticfiles import StaticFiles
from starlette.exceptions import HTTPException
from modulos.seguridad.r_authentication import SessionData, test_session
from modulos.seguridad import initBDSeguridad, r_authentication
from modulos.restaurant import r_restaurant

# Ejecutar los archivos de scritps de sql de cambios sobre estructuras y datos de la base de datos
if not createLastChangesInDB():
    print('Se presentaron errores de conexión con el servidor de base de datos y con los scripts de actualizaciones')
else:
    # Inicializar estructuras y datos del modulo de seguridad
    initBDSeguridad.initBDdatos()

app = FastAPI( title="Comidas")

app.mount("/static", StaticFiles(directory="static"), name="static")

app.include_router(r_authentication.router)
app.include_router(r_restaurant.router)

HOST="127.0.0.1"
PORT=8000
print (f"Presiona CTRL + click en: http://{HOST}:{PORT}")
if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host=HOST, port=PORT)
