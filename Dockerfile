FROM python:3.7

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY local_settings.py.example apimanager/apimanager/local_settings.py 
# To pass local settings during run time, pass as volume e.g. 
# docker run -v /your-local-path-to/API-Manager/local_settings.py.example:/usr/src/app/apimanager/apimanager/local_settings.py -p 8000:8000
COPY . .
# Migrate database
RUN apimanager/manage.py migrate

EXPOSE 8000
WORKDIR /usr/src/app/apimanager
RUN ls -l
# apimanager, send access and error logs to stdout by default
CMD ["gunicorn", "apimanager.wsgi", "--bind", "0.0.0.0:8000"]
