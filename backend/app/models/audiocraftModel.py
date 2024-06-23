import torch
import torchaudio
from audiocraft.models import MusicGen

class AudioCraftModel:
    def __init__(self):
        self.model = MusicGen.get_pretrained('melody_large')

    def generate_long_audio(self, text: str, duration: int, topk: int = 250, topp: float = 0.0, temperature: float = 1.0, cfg_coef: float = 3.0, overlap: int = 5):
        topk = int(topk)
        output = None
        segment_duration = duration

        while duration > 0:
            if output is None:
                segment_duration = min(segment_duration, self.model.lm.cfg.dataset.segment_duration)
            else:
                segment_duration = min(segment_duration + overlap, self.model.lm.cfg.dataset.segment_duration)

            self.model.set_generation_params(
                use_sampling=True,
                top_k=topk,
                top_p=topp,
                temperature=temperature,
                cfg_coef=cfg_coef,
                duration=min(segment_duration, 30),
            )

            if output is None:
                next_segment = self.model.generate(descriptions=[text])
                duration -= segment_duration
            else:
                last_chunk = output[:, :, -overlap * self.model.sample_rate:]
                next_segment = self.model.generate_continuation(last_chunk, self.model.sample_rate, descriptions=[text])
                duration -= segment_duration - overlap

            if output is None:
                output = next_segment
            else:
                output = torch.cat([output[:, :, :-overlap * self.model.sample_rate], next_segment], 2)

            audio_output = output.detach().cpu().float()[0]
            torchaudio.save(f"segment_{duration}.wav", audio_output, sample_rate=32000)
            yield audio_output, f"segment_{duration}.wav"
