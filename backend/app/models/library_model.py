import json
from difflib import SequenceMatcher
import os

class LibraryModel:
    def __init__(self, library_file='app/models/library.json', tracks_folder='app/generated_tracks'):
        self.library_file = library_file
        self.tracks_folder = tracks_folder
        self.library = self.load_library()
        print(f"Library loaded: {self.library}")  # Debugging

    def load_library(self):
        if os.path.exists(self.library_file):
            try:
                with open(self.library_file, 'r') as file:
                    return json.load(file)
            except FileNotFoundError:
                return []
        else:
            # Create the file if it doesn't exist and add initial data
            with open(self.library_file, 'w') as file:
                initial_data = []
                json.dump(initial_data, file, indent=4)
            return []

    def save_library(self):
        with open(self.library_file, 'w') as file:
            json.dump(self.library, file, indent=4)

    def find_best_match(self, user_prompt):
        best_match = None
        highest_similarity = 0
        print(f"Finding best match for: {user_prompt}")  # Debugging

        for track in self.library:
            similarity = self.calculate_similarity(user_prompt, track['prompt'])
            print(f"Checking track: {track}, similarity: {similarity}")  # Debugging
            if similarity > highest_similarity:
                highest_similarity = similarity
                best_match = track

        print(f"Best match: {best_match}, similarity: {highest_similarity}")  # Debugging
        return best_match

    def calculate_similarity(self, prompt1, prompt2):
        return SequenceMatcher(None, prompt1.lower(), prompt2.lower()).ratio()

    def add_track(self, prompt, filename):
        self.library.append({"prompt": prompt, "filename": filename})
        self.save_library()

    def get_all_tracks(self):
        return self.library

    def get_track_path(self, filename):
        return os.path.join(self.tracks_folder, filename)
