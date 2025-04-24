FROM debian:bookworm-slim

# 1. نثبت Python و pip وننظف الـ apt cache لتقليل الحجم
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      python3 python3-pip \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 2. ننسخ ملف المتطلبات
COPY requirements.txt .

# 3. نثبت الحزم عبر pip3
RUN python3 -m pip install --no-cache-dir -r requirements.txt \
 && python3 -m pip install --no-cache-dir --upgrade setuptools==70.0.0

# 4. ننسخ باقي الكود
COPY . .

# 5. نشغّل التطبيق
CMD ["python3", "app.py"]
