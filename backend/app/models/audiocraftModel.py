import torch
import torchaudio
import os
from audiocraft.models import MusicGen

class AudioCraftModel:
    def __init__(self):
        self.model = MusicGen.get_pretrained('facebook/musicgen-large')
        self.segment_duration = 15  # Fixed segment duration of 15 seconds
        self.sample_rate = 32000
        self.chunk_duration = 2 * 60 + 5  # 2 minutes and 5 seconds chunks for streaming

    def generate_long_audio(self, text: str, total_duration: int, overlap: int = 5):
        segments = []
        remaining_duration = total_duration
        total_generated_duration = 0
        chunk_counter = 0

        while remaining_duration > 0:
            current_segment_duration = min(self.segment_duration, remaining_duration + overlap)

            # Set the generation parameters
            self.model.set_generation_params(
                use_sampling=True,
                duration=current_segment_duration,
            )

            if not segments:
                next_segment = self.model.generate(descriptions=[text])
                remaining_duration -= self.segment_duration
                total_generated_duration += self.segment_duration
            else:
                last_chunk = segments[-1][:, :, -overlap * self.sample_rate:]
                next_segment = self.model.generate_continuation(last_chunk, self.sample_rate, descriptions=[text])
                remaining_duration -= (self.segment_duration - overlap)
                total_generated_duration += (self.segment_duration - overlap)

            segments.append(next_segment.detach().cpu().float())

            # Collect segments into 2-minute and 5-second chunks for streaming
            if total_generated_duration >= self.chunk_duration:
                yield self._concatenate_segments(segments, overlap, chunk_counter)
                segments = segments[-1:]  # Keep only the last segment for the next chunk
                total_generated_duration = overlap  # Reset duration count, including overlap
                chunk_counter += 1

        # Yield the last chunk if any segments are left
        if segments:
            yield self._concatenate_segments(segments, overlap, chunk_counter)

    def _concatenate_segments(self, segments, overlap, chunk_counter):
        output = segments[0]
        for segment in segments[1:]:
            output = torch.cat([output[:, :, :-overlap * self.sample_rate], segment], 2)
        audio_output = output[0]
        output_dir = 'music'
        os.makedirs(output_dir, exist_ok=True)
        filename = f"chunk_{chunk_counter}.wav"
        filepath = os.path.join(output_dir, filename)
        torchaudio.save(filepath, audio_output, sample_rate=self.sample_rate)
        return audio_output, filepath
