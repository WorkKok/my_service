from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {
        "message": "ТЕСТ!",
        "student": "Коровайко_Дмитрий",
        "group": "21_к_ас_1",
        "project": "Secure Service",
        "status": "running"
    }

@app.get("/health")
def health():
    return {"status": "ok"}
