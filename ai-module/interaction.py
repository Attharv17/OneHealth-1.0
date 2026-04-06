interaction_db = {
    ("aspirin", "warfarin"): "⚠️ High bleeding risk",
    ("ibuprofen", "paracetamol"): "⚠️ Liver risk if overused"
}

def check_interactions(drugs):
    warnings = []

    for i in range(len(drugs)):
        for j in range(i+1, len(drugs)):
            pair = (drugs[i].lower(), drugs[j].lower())
            if pair in interaction_db:
                warnings.append(interaction_db[pair])

    return warnings