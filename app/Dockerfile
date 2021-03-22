FROM python:3.9-alpine

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install individual dependencies
RUN apk add --update --no-cache --virtual .tmp-build-deps \
	&& apk add gcc libc-dev linux-headers postgresql-dev postgresql-client

RUN pip install --upgrade pip
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Remove temporaries
RUN apk del .tmp-build-deps

# Copy project
RUN mkdir /app
WORKDIR /app
COPY ./gtd/ /app
# RUN django-admin.py startproject project .
COPY ./django-todo/todo /app/todo
COPY ./local.py /app/project/ 
RUN rm /app/project/local.example.py
COPY ./settings.py /app/project/

# [Security] Limit the scope of user who run the docker image
RUN adduser -D user
USER user

COPY ./docker-entrypoint.sh /app

EXPOSE 8000  

# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
ENTRYPOINT [ "/bin/sh", "/app/docker-entrypoint.sh" ]