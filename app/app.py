import os
import pickle
import numpy as np
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from prometheus_fastapi_instrumentator import Instrumentator

# Initialize FastAPI App
app = FastAPI(
    title="AI Inference API",
    description="Production-ready FastAPI service for Scikit-Learn model predictions",
    version="1.0.0"
)

# Instrument Prometheus metrics on app startup
Instrumentator().instrument(app).expose(app)

# Load Scikit-Learn model
MODEL_PATH = os.path.join(os.path.dirname(__file__), "model.pkl")

if not os.path.exists(MODEL_PATH):
    raise FileNotFoundError(f"Model file not found at {MODEL_PATH}. Make sure to run train.py first.")

with open(MODEL_PATH, "rb") as f:
    model = pickle.load(f)

# Request validation schema
class PredictionRequest(BaseModel):
    feature1: float
    feature2: float

    model_config = {
        "json_schema_extra": {
            "example": {
                "feature1": 10.0,
                "feature2": 20.0
            }
        }
    }

# Response schema
class PredictionResponse(BaseModel):
    prediction: str

@app.post("/predict", response_model=PredictionResponse)
def predict(request: PredictionRequest):
    try:
        # Prepare input array for inference
        features = np.array([[request.feature1, request.feature2]])
        
        # Run prediction (returns 0 or 1)
        pred = model.predict(features)[0]
        
        # Map output label
        prediction_label = "approved" if pred == 1 else "rejected"
        
        return PredictionResponse(prediction=prediction_label)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Inference failed: {str(e)}")

@app.get("/health")
def health():
    """Liveness and Readiness Probe endpoint"""
    return {"status": "healthy", "model_loaded": model is not None}
