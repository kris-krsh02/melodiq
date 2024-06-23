import os
from difflib import SequenceMatcher

class LibraryModel:
    def __init__(self):
        self.library = []

    def find_best_match(self, user_prompt):
        best_match = None
        highest_similarity = 0

        for track in self.library:
            similarity = self.calculate_similarity(user_prompt, track['prompt'])
            if similarity > highest_similarity:
                highest_similarity = similarity
                best_match = track

        return best_match

    def calculate_similarity(self, prompt1, prompt2):
        return SequenceMatcher(None, prompt1.lower(), prompt2.lower()).ratio()

    def add_track(self, prompt, filename):
        self.library.append({"prompt": prompt, "filename": filename})
