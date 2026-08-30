#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
	echo "Usage: $0 <directory>" >&2
	exit 1
fi

dir="$1"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
main_typ="$script_dir/$dir/main.typ"

if [ ! -f "$main_typ" ]; then
	echo "Error: $main_typ not found" >&2
	exit 1
fi

typst compile --root "$script_dir" "$main_typ" "$script_dir/$dir/main.pdf"

