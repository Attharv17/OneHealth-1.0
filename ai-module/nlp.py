import spacy

# Load model
nlp = spacy.load("en_core_web_sm")

# Input text (IMPORTANT)
text = "Patient has fever and diabetes. Prescribed paracetamol and insulin."

# Process text
doc = nlp(text)

# Print named entities (optional)
for ent in doc.ents:
    print(ent.text, ent.label_)

# Define lists
diseases = ["diabetes", "fever", "hypertension"]
meds = ["paracetamol", "insulin"]

# Convert text to lowercase once
text_lower = text.lower()

# Find matches
found_disease = [w for w in diseases if w in text_lower]
found_meds = [w for w in meds if w in text_lower]

# Print results
print("Diseases found:", found_disease)
print("Medicines found:", found_meds)