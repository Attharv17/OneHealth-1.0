from pydantic import BaseModel
from typing import List

class User(BaseModel):
    name: str
    email: str
    password: str

class Record(BaseModel):
    user_id: str
    diseases: List[str]
    medications: List[str]
    allergies: List[str]