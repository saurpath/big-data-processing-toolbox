FROM python:latest
COPY . /usr/src/project
WORKDIR /usr/src/project
RUN pip install --no-cache-dir -U flask
CMD ["python3","toolbox-frontend.py"]