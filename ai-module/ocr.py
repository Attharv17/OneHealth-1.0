def extract_text(image_path):
    import easyocr

    reader = easyocr.Reader(['en'])
    result = reader.readtext(image_path, detail=0)

    text = " ".join(result)
    return text