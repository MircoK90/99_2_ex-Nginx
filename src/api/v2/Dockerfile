FROM python:3.10-slim

WORKDIR /app

COPY src/api/requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY src/api/v2/main.py /app/
COPY model/model.joblib /app/model.joblib

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]