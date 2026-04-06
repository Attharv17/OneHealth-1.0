import os
from motor.motor_asyncio import AsyncIOMotorClient
from dotenv import load_dotenv

load_dotenv()

MONGODB_URL = os.getenv("MONGODB_URL")
DATABASE_NAME = os.getenv("DATABASE_NAME")

# Create async client
client = AsyncIOMotorClient(MONGODB_URL)
database = client[DATABASE_NAME]

# Define collections
patient_collection = database.get_collection("patients")
record_collection = database.get_collection("medical_records")