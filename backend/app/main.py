from fastapi import FastAPI
from .database import client

app = FastAPI()

@app.on_event("startup")
async def startup_db_client():
    try:
        # The ping command is cheap and confirms a successful connection
        await client.admin.command('ping')
        print("✅ Successfully connected to MongoDB Atlas!")
    except Exception as e:
        print(f"❌ Could not connect to MongoDB: {e}")

@app.on_event("shutdown")
async def shutdown_db_client():
    client.close()

@app.get("/")
async def root():
    return {"message": "OneHealth API is Live"}