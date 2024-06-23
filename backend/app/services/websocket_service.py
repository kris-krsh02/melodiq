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
        print(f"Received prompt: {user_prompt}")
        best_match = library_model.find_best_match(user_prompt)

        if best_match:
            filename = best_match['filename']
            print(f"Best match found: {filename}")
            await websocket.send_text(f"title:{filename}")
            await send_audio_file(websocket, filename)
        
        await websocket.send_text("END_OF_DATA")
        
        print("Generating new track...")
        filepath, filename = await generate_and_store_track(user_prompt)
        library_model.add_track(user_prompt, filename)
        print(f"New track generated: {filename}")

    except WebSocketDisconnect:
        print("Client disconnected")
    except Exception as e:
        print(f"Error: {e}")

async def generate_and_store_track(prompt: str):
    # Ensure the directory exists
    directory = os.path.join(os.path.dirname(__file__), '..', 'generated_tracks')
    if not os.path.exists(directory):
        os.makedirs(directory)

    filepath, filename = await generation_model.generate_track(prompt)
    library_model.add_track(prompt, filename)  # Save the track to the library
    return filepath, filename

async def send_audio_file(websocket: WebSocket, filename: str):
    filepath = os.path.join(os.path.dirname(__file__), '..', 'generated_tracks', filename)
    if os.path.exists(filepath):
        print(f"Sending file: {filepath}")
        with open(filepath, 'rb') as audio_file:
            while chunk := audio_file.read(4096):
                await websocket.send_bytes(chunk)
    else:
        print(f"File not found: {filepath}")
        await websocket.send_text("Error: File not found")
