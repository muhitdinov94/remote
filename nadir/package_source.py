"""Package only the reviewed source manifest, excluding build products and credentials."""
# SPDX-License-Identifier: AGPL-3.0-only
import argparse
from pathlib import Path
import zipfile

ROOT = Path(__file__).resolve().parent.parent

def package(destination):
    destination = Path(destination).resolve()
    entries = (ROOT / 'nadir/source-files.txt').read_text(encoding='utf-8').splitlines()
    if not entries or len(entries) != len(set(entries)):
        raise ValueError('Source manifest is empty or has duplicate entries')
    resolved = []
    for relative in entries:
        path = ROOT / relative
        if path.is_symlink() or not path.is_file() or not path.resolve().is_relative_to(ROOT):
            raise ValueError(f'Missing or unsafe source file: {relative}')
        if path.resolve() == destination or '.git' in path.parts:
            raise ValueError(f'Invalid source entry: {relative}')
        resolved.append((relative, path))
    with zipfile.ZipFile(destination, 'w', zipfile.ZIP_DEFLATED) as archive:
        for relative, path in resolved:
            archive.write(path, 'NadirRemote/' + relative)
    print(f'{destination.name}: {len(resolved)} source files, {destination.stat().st_size} bytes')

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('destination')
    package(parser.parse_args().destination)
