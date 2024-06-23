import json
from difflib import SequenceMatcher

class LibraryModel:
    def __init__(self, library_file='library.json'):
        self.library_file = library_file
        self.library = self.load_library()

    def load_library(self):
        try:
            with open(self.library_file, 'r') as file:
                return json.load(file)
        except FileNotFoundError:
            return []

    def save_library(self):
        with open(self.library_file, 'w') as file:
            json.dump(self.library, file, indent=4)

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
        self.save_library()

    def get_all_tracks(self):
        return self.library
