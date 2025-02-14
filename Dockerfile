FROM python:3.9-slim AS build

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.9-slim
COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=build /usr/local/bin /usr/local/bin

WORKDIR /app

COPY setup.sh .
COPY app.py .

RUN chmod +x setup.sh

CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]

