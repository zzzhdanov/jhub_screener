import os
import json

target = '/home'
avoid_list = ['admin', 'nativeauthenticator']

with os.scandir(target) as files:
    users_dir = [file.name for file in files if (file.is_dir() and file.name not in avoid_list)]

for user in users_dir:
    with open(f'/home/{user}/auto.ipynb', 'r', encoding='utf-8') as f:
        notebook_content = json.load(f)
    cells = notebook_content['cells']

    if cells:
        first_cell_content = cells[0]['source']
        if first_cell_content[0] == "WORKING":
            os.system(f'cd /home/{user} && ipython --TerminalIPythonApp.file_to_run=auto.ipynb')
