from pymongo import MongoClient

MONGO_URL = "mongodb+srv://pravar:pravar@onehealth.rgkxgru.mongodb.net/?retryWrites=true&w=majority"

client = None
db = None

try:
    client = MongoClient(MONGO_URL)
    
    # Test connection
    client.admin.command("ping")
    print("✅ MongoDB Connected Successfully")

    # Database name (you can change if needed)
    db = client["onehealth"]

except Exception as e:
    print("❌ MongoDB Connection Failed:", e)

if db is not None:
    users_collection = db["users"]
    records_collection = db["records"]
else:
    users_collection = None
    records_collection = None