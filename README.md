## comidas

Cómo ejecutar el proyecto:
Instalar python 3,
Abrir la terminal, estando en el directorio actual, ejecutar:
  Pip install virtualenv
  virtualenv venv
  o bien: venv venv
Cerrar la terminal y abrir una nueva para que automáticamente abra la terminal en el entorno virtual venv
posteriormente ejecutar:
  python.exe -m pip install --upgrade pip

  pip install -r .\requirements.txt

  uvicorn main:app --host 0.0.0.0 --port [puerto]
  <!-- especificar el puerto de su preferencia sin llaves -->
