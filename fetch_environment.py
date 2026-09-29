#!/usr/bin/env python3
"""Deprecated wrapper - use `PYTHONPATH=src python3 -m wds fetch-env`."""

from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent / "src"))

from wds.api import ApiClient  # noqa: E402


def main() -> None:
    env = ApiClient().fetch_environment()
    print(json.dumps(env.__dict__, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
