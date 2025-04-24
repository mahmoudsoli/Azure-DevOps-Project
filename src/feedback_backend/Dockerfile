FROM debian:bookworm-slim 
#FROM python:3.9-slim

WORKDIR /app

# Copy from the actual root
COPY requirements.txt .

RUN pip install -r requirements.txt
RUN pip install --upgrade setuptools==70.0.0

COPY . .

CMD ["python", "app.py"]