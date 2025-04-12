FROM python:3.9-slim

WORKDIR /app

# Copy from the actual root
COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]