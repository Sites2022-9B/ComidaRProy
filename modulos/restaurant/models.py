from ..shared_models import *
from sqlalchemy.sql.sqltypes import DECIMAL, Date

class Restaurant(Base):
    __tablename__ = 'restaurant'
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    razon_social = Column(String, index=True)
    nombre_contacto = Column(String, index=True)
    clabe = Column(String, index=True)
    direccion = Column(String, index=True)
    telefono = Column(String, index=True)
    email = Column(String, ForeignKey("user.email"),index=True)
    facebook = Column(String, nullable=False)
    twitter = Column(String, index=True)
    instagram = Column(String, index=True)
    logotipo = Column(String, index=True)
    status = Column(String, index=True)
    ubicacion_lat = Column(String, index=True)
    ubicacion_long = Column(String, index=True)
    verificado = Column(String, index=True)
    created_at = Column(DateTime(), nullable=True)
    updated_at = Column(DateTime(), nullable=True)
    deleted_at = Column(DateTime(), nullable=True)

class Platillos(Base):
    __tablename__ = 'platillos'
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    id_restaurant = Column(String, ForeignKey("restaurant.id"),index=True)
    nombre = Column(String, index=True)
    descripcion = Column(String, index=True)
    precio = Column(DECIMAL(precision=10, scale=2), index=True)
    imagen = Column(String, index=True) 
    categoria = Column(String, index=True) 
    status = Column(String, index=True) 

# class PedidoPlatillos(Base):
#     __tablename__ = 'pedido_platillos'
#     id_pedido = Column(Integer,ForeignKey("pedidos.id"), index=True)
#     id_platillo = Column(String,ForeignKey("platillos.id"), index=True)
#     id_envio = Column(String, index=True)
#     cantidad = Column(String, index=True)
#     precio = Column(DECIMAL(precision=10, scale=2), index=True)

