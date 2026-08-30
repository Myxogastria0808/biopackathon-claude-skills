import os
import sys

sys.path.insert(0, os.path.abspath("../src"))

project = "biopackathon-claude-skills"
extensions = [
    "sphinx.ext.autodoc",
    "sphinx.ext.napoleon",
    "sphinx.ext.todo",
]

napoleon_google_docstring = True
napoleon_numpy_docstring = False

html_theme = "sphinx_rtd_theme"

