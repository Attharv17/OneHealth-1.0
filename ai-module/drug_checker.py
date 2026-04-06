# Example input (you should pass this from NLP module)
found_meds = ["paracetamol", "ibuprofen"]

# Define interactions
interactions = {
    ("paracetamol", "ibuprofen"): "Risk of liver damage"
}

# Normalize pairs to avoid order issues
for i in range(len(found_meds)):
    for j in range(i + 1, len(found_meds)):
        d1 = found_meds[i]
        d2 = found_meds[j]

        # Check both orders
        if (d1, d2) in interactions:
            print("Alert:", interactions[(d1, d2)])
        elif (d2, d1) in interactions:
            print("Alert:", interactions[(d2, d1)])