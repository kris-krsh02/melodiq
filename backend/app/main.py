from models.audiocraftModel import AudioCraftModel

def main():
    model = AudioCraftModel()
    prompt = "Lofi hip hop beats with a synthwave twist."
    duration = 6 * 60 # seconds
    for audio_output, filename in model.generate_long_audio(prompt, duration):
        print(f"Generated segment saved as {filename}")

if __name__ == "__main__":
    main()
