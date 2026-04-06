from fastapi import APIRouter, UploadFile, File
from database import records_collection
from models import Record
from ai_mock import extract_text_mock, generate_summary_mock, drug_interaction_mock

router = APIRouter()

# Upload report (FAKE OCR)
@router.post("/upload")
async def upload_file(file: UploadFile = File(...)):
    text = extract_text_mock()
    return {
        "message": "File processed",
        "extracted_text": text
    }

# Save medical record
@router.post("/record")
def create_record(record: Record):
    records_collection.insert_one(record.dict())
    
    summary = generate_summary_mock(record.dict())
    alert = drug_interaction_mock(record.medications)

    return {
        "message": "Record saved",
        "summary": summary,
        "alert": alert
    }

# Get records
@router.get("/record/{user_id}")
def get_records(user_id: str):
    records = list(records_collection.find({"user_id": user_id}, {"_id": 0}))
    return {"records": records}