FROM python:3.10.8-slim

WORKDIR /app
COPY  . .
ENV PYTHONPATH=$PYTHONPATH:/app
ENV APP_BASE=/app/

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    && apt-get clean

COPY requirements.txt .
RUN pip --disable-pip-version-check install -r requirements.txt
EXPOSE 8080

CMD ["python", "app.py"]
