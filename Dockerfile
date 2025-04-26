FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    gcc \
    && apt-get clean

COPY . /app

WORKDIR /app/Server-Setup

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

EXPOSE 8792

CMD ["gunicorn", "server:app"]
