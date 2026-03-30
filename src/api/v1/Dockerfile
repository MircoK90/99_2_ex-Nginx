FROM python:3.10-slim

WORKDIR /app

COPY ../../requrements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY ../../model /model
COPY main.py .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]