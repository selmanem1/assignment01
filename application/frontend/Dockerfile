FROM python:3.10.8-slim

WORKDIR /app
COPY  ./frontend .

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    && apt-get clean

COPY requirements.txt .
RUN pip --disable-pip-version-check install -r requirements.txt
EXPOSE 8080

CMD ["python", "app.py"]
