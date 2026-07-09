# Stage 1: Build and Train
FROM python:3.11-slim as builder

WORKDIR /app

# Install compilation dependencies and libraries
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Copy training helper and execute to produce model.pkl
COPY train.py .
RUN python train.py

# Stage 2: Production Runtime Image
FROM python:3.11-slim as runner

WORKDIR /app

# Import dependencies and trained model from builder
COPY --from=builder /root/.local /root/.local
COPY --from=builder /app/model.pkl /app/model.pkl
COPY app.py .

# Update path environment variable to find uvicorn and dependencies
ENV PATH=/root/.local/bin:$PATH

# Expose FastAPI server port
EXPOSE 8000

# Set production execution command
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
