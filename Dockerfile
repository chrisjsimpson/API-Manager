FROM python:3.7

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY local_settings.py.example apimanager/apimanager/local_settings.py 
COPY . .
# Migrate database
RUN apimanager/manage.py migrate

EXPOSE 8080
CMD ["python", "apimanager/manage.py", "runserver", "0.0.0.0:8080"]
