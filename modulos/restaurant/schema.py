from pydantic import BaseModel

class PlatilloAdd(BaseModel):
    api_token:int
    nombre: str
    descripcion: str
    precio: str
    categoria: str