import os
from fastapi import WebSocket, WebSocketDisconnect
from app.models.library_model import LibraryModel
from app.models.generation_model import GenerationModel
import asyncio

library_model = LibraryModel()
generation_model = GenerationModel()

async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        user_prompt = await websocket.receive_text()
        best_match = library_model.find_best_match(user_prompt)

        if best_match:
            filename = best_match['filename']
            await websocket.send_text(f"Playing pre-generated track: {filename}")
            await send_audio_file(websocket, filename)
        else:
            await websocket.send_text("No matching track found, generating new track...")
            filepath, filename = await generate_and_store_track(user_prompt)
            library_model.add_track(user_prompt, filename)
            await websocket.send_text(f"Generated and playing new track: {filename}")
            await send_audio_file(websocket, filename)
    except WebSocketDisconnect:
        print("Client disconnected")
    except Exception as e:
        print(f"Error: {e}")

async def generate_and_store_track(prompt: str):
    filepath, filename = await generation_model.generate_track(prompt)
    library_model.add_track(prompt, filename)  # Save the track to the library
    return filepath, filename

async def send_audio_file(websocket: WebSocket, filename: str):
    filepath = os.path.join('generated_tracks', filename)
    with open(filepath, 'rb') as audio_file:
        while chunk := audio_file.read(4096):  # Read in chunks of 4096 bytes
            await websocket.send_bytes(chunk)
