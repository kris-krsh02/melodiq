from models.audiocraftModel import AudioCraftModel

def main():
    model = AudioCraftModel()
    prompt = "Relaxing ambient music with nature sounds"
    file_name = model.generate_audio(prompt, duration=15)  # Generate 30 seconds of music
    print(f"Generated audio saved as {file_name}")

if __name__ == "__main__":
    main()
