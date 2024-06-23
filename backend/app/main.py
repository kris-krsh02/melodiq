import asyncio
from models.generationModel import GenerationModel

async def main():
    model = GenerationModel()
    prompt = "Lofi hip hop beats with a synthwave twist."
    await model.generate_track(prompt)

if __name__ == "__main__":
    asyncio.run(main())
