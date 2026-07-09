import os
import pickle
import numpy as np
from sklearn.linear_model import LogisticRegression

def train():
    # Synthetic data matching the business logic of predicting approval based on 2 features
    X = np.array([
        [15, 15],  # Sum = 30 -> Approved (1)
        [10, 20],  # Sum = 30 -> Approved (1)
        [5, 5],    # Sum = 10 -> Rejected (0)
        [12, 18],  # Sum = 30 -> Approved (1)
        [8, 10],   # Sum = 18 -> Rejected (0)
        [2, 3],    # Sum = 5  -> Rejected (0)
        [20, 20],  # Sum = 40 -> Approved (1)
        [6, 7],    # Sum = 13 -> Rejected (0)
        [11, 15],  # Sum = 26 -> Approved (1)
        [1, 1],    # Sum = 2  -> Rejected (0)
    ])
    y = np.array([1, 1, 0, 1, 0, 0, 1, 0, 1, 0])

    model = LogisticRegression()
    model.fit(X, y)

    # Save model.pkl in the same directory as this script
    output_path = os.path.join(os.path.dirname(__file__), "model.pkl")
    with open(output_path, "wb") as f:
        pickle.dump(model, f)
    print(f"Model successfully trained and saved to {output_path}")

if __name__ == "__main__":
    train()
