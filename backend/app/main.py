from fastapi import FastAPI, WebSocket
from app.services.websocket_service import websocket_endpoint

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "FastAPI server is running"}

@app.websocket("/ws/audio")
async def websocket_audio(websocket: WebSocket):
    await websocket_endpoint(websocket)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
