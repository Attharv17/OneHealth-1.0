def generate_summary(text, diseases, meds):
    text_lower = text.lower()

    found_disease = [d for d in diseases if d in text_lower]
    found_meds = [m for m in meds if m in text_lower]

    summary = f"""
    Patient Summary:
    Diseases: {', '.join(found_disease) if found_disease else 'None'}
    Medicines: {', '.join(found_meds) if found_meds else 'None'}
    """

    return summary