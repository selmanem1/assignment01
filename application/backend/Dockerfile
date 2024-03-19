FROM python:3.10.8-slim

WORKDIR /app
COPY  ./backend .

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    && apt-get clean

COPY requirements.txt .
RUN pip --disable-pip-version-check install -r requirements.txt
EXPOSE 5001

CMD ["python", "app.py"]
