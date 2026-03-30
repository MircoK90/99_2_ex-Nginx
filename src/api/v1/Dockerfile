FROM python:3.10-slim

WORKDIR /app

COPY src/api/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/api/v1/main.py .
COPY model/model.joblib ./model.joblib

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]