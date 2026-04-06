from fastapi import FastAPI, File, UploadFile
import shutil
import easyocr
import spacy
import os

app = FastAPI()

# Create uploads folder
UPLOAD_FOLDER = "uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# Load models
reader = easyocr.Reader(['en'])
nlp = spacy.load("en_core_web_sm")

# Medical keywords
DISEASES = [
    "diabetes", "fever", "hypertension", "asthma",
    "heart disease", "infection"
]

MEDICINES = [
    "paracetamol", "insulin", "ibuprofen",
    "aspirin", "metformin"
]

INTERACTIONS = {
    ("paracetamol", "ibuprofen"): "Risk of stomach/liver damage"
}

@app.get("/")
def home():
    return {"message": "AI Healthcare API is running"}

@app.post("/analyze/")
async def analyze(file: UploadFile = File(...)):
    
    file_path = os.path.join(UPLOAD_FOLDER, file.filename or "uploaded_file")
    
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    # OCR
    result = reader.readtext(file_path, detail=0)

    # Safe join
    text = " ".join([str(r) for r in result])

    print("OCR TEXT:", text)  # For demo visibility

    text_lower = text.lower()

    # NLP (keyword-based)
    found_diseases = [d for d in DISEASES if d in text_lower]
    found_meds = [m for m in MEDICINES if m in text_lower]

    # Drug interaction check
    alerts = []
    for d1 in found_meds:
        for d2 in found_meds:
            if (d1, d2) in INTERACTIONS:
                alerts.append(INTERACTIONS[(d1, d2)])

    return {
        "Patient Summary": text[:200],
        "Detected Diseases": found_diseases,
        "Detected Medications": found_meds,
        "Risk Alerts": alerts if alerts else ["No major interactions"]
    }