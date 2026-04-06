import sys
import os
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
from fastapi import FastAPI
from routes import user, records

app = FastAPI()

app.include_router(user.router, prefix="/user")
app.include_router(records.router, prefix="/records")

@app.get("/")
def home():
    return {"message": "OneHealth API Running"}

@app.get("/test-db")
def test_db():
    from database import db
    if db:
        return {"status": "connected"}
    return {"status": "failed"}