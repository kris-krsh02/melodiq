import torch
import torchaudio
import os
import asyncio
from audiocraft.models import MusicGen

class GenerationModel:
    def __init__(self):
        self.model = MusicGen.get_pretrained('facebook/musicgen-large')
        self.segment_duration = 15  # Fixed segment duration of 15 seconds
        self.sample_rate = 32000

    async def generate_track(self, text: str, duration: int = 5 * 60):
        segments = []
        remaining_duration = duration

        while remaining_duration > 0:
            current_segment_duration = min(self.segment_duration, remaining_duration)
            self.model.set_generation_params(
                use_sampling=True,
                duration=current_segment_duration,
            )

            if not segments:
                next_segment = await asyncio.to_thread(self.model.generate, descriptions=[text])
                remaining_duration -= current_segment_duration
            else:
                last_chunk = segments[-1][:, :, -self.sample_rate:]
                next_segment = await asyncio.to_thread(self.model.generate_continuation, last_chunk, self.sample_rate, descriptions=[text])
                remaining_duration -= current_segment_duration

            segments.append(next_segment.detach().cpu().float())

        # Concatenate all segments
        output = torch.cat(segments, 2)
        audio_output = output[0]
        output_dir = 'generated_tracks'
        os.makedirs(output_dir, exist_ok=True)
        filename = f"{text.replace(' ', '_')}.wav"
        filepath = os.path.join(output_dir, filename)
        await asyncio.to_thread(torchaudio.save, filepath, audio_output, sample_rate=self.sample_rate)
        return filepath, filename
