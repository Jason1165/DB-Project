FROM python:3.11

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    python3-venv \
    libffi-dev \
    build-essential

COPY . .

RUN cd Server-Setup && python3 -m venv venv
RUN cd Server-Setup && . venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt

CMD ["bash", "-c", "cd Server-Setup && . venv/bin/activate && gunicorn server:app"]
