def extract_text_mock():
    return "Patient has diabetes and hypertension."

def generate_summary_mock(data):
    return f"Patient has {', '.join(data['diseases'])}. Taking {', '.join(data['medications'])}"

def drug_interaction_mock(medications):
    if len(medications) > 1:
        return "⚠️ Potential drug interaction detected"
    return "No major interactions"