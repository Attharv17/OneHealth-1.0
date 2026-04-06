from fastapi import FastAPI

app = FastAPI(
    title="OneHealth API",
    description="Backend for the OneHealth patient records and AI summary platform.",
    version="1.0.0"
)

@app.get("/")
async def root():
    return {"message": "Welcome to the OneHealth API"}

@app.get("/health")
async def health_check():
    return {"status": "Backend is running smoothly!"}   