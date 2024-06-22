import torch
import torchaudio
import os
from audiocraft.models import MusicGen

class AudioCraftModel:
    def __init__(self):
        self.model = MusicGen.get_pretrained('facebook/musicgen-medium ')

    def generate_audio(self, text: str, duration: int = 30):
        self.model.set_generation_params(duration=duration)
        generated_audio = self.model.generate(descriptions=[text])
        audio_output = generated_audio.detach().cpu().float()[0]
        
        # Ensure the output directory exists
        output_dir = "music"
        os.makedirs(output_dir, exist_ok=True)
        
        file_name = os.path.join(output_dir, "generated_audio_2.wav")
        torchaudio.save(file_name, audio_output.clone().detach(), sample_rate=32000)
        return file_name
