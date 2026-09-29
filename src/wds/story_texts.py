"""Scene bin decoding and dialogue-text export for WDS stories.

CDN scene .bin wire format (verified against the game):

    gzip -> msgpack stream -> ext-98 LZ4 frame -> dialogue rows

Each decoded row carries the dialogue at position 7:

    [pageId, episodeId, page, order, None, speaker, None, text, ...]

TextCollector writes one JSON document per episode into texts_dir and keeps
an index.json summary; story.py uses it during the bulk reader run.
"""

from __future__ import annotations

import gzip
import json
import threading
import urllib.request
from pathlib import Path
from typing import Any

from . import codec


COMPANY_NAMES: dict[int, str] = {
    1: "シリウス",
    2: "Eden",
    3: "銀河座",
    4: "劇団電姫",
    5: "コラボ",
    900: "ラブライブサンシャイン",
    999: "序章",
}


def company_label(company_id: int | None) -> str:
    if company_id is None:
        return ""
    return COMPANY_NAMES.get(company_id, f"company{company_id}")


def find_scene_file(scenes_dir: str, episode_id: int) -> Path | None:
    hits = list(Path(scenes_dir).glob(f"{episode_id}_*.bin"))
    return hits[0] if hits else None


def decode_scene_lines(path: str | Path) -> list[dict[str, Any]]:
    """Decode one scene .bin into deduplicated dialogue lines."""
    raw = gzip.decompress(Path(path).read_bytes())
    decoded = codec.decode_response(raw)
    lines: list[dict[str, Any]] = []
    seen: set[tuple[Any, ...]] = set()
    for obj in decoded:
        if not isinstance(obj, list):
            continue
        for row in obj:
            if (
                isinstance(row, list)
                and len(row) > 7
                and isinstance(row[7], str)
                and row[7]
            ):
                key = (row[2], row[3], row[5], row[7])
                if key in seen:
                    continue
                seen.add(key)
                lines.append(
                    {
                        "page": row[2] if isinstance(row[2], int) else None,
                        "order": row[3] if isinstance(row[3], int) else None,
                        "speaker": row[5] if isinstance(row[5], str) else None,
                        "text": row[7],
                    }
                )
    return lines


def download_scene(url: str, dest: str | Path, timeout: int = 120) -> None:
    req = urllib.request.Request(url, headers={"user-agent": "BestHTTP/2 v2.8.5"})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        data = resp.read()
    Path(dest).write_bytes(data)


class TextCollector:
    """Thread-safe per-episode dialogue export with an index summary."""

    def __init__(self, texts_dir: str | Path):
        self.texts_dir = Path(texts_dir)
        self.texts_dir.mkdir(parents=True, exist_ok=True)
        self._index: dict[str, Any] = {}
        self._lock = threading.Lock()

    def add(
        self,
        episode_id: int,
        *,
        kind: str,
        title: str,
        company_id: int | None,
        scene_path: Path,
    ) -> int:
        """Decode the scene and export it; returns the line count (-1 on error)."""
        try:
            lines = decode_scene_lines(scene_path)
        except Exception as ex:  # noqa: BLE001
            with self._lock:
                self._index[str(episode_id)] = {"error": f"{type(ex).__name__}: {ex}"}
            return -1
        entry = {
            "id": episode_id,
            "kind": kind,
            "title": title,
            "company": company_label(company_id),
            "scene": scene_path.name,
            "lines": lines,
        }
        with self._lock:
            (self.texts_dir / f"{episode_id}.json").write_text(
                json.dumps(entry, ensure_ascii=False, indent=2),
                encoding="utf-8",
            )
            self._index[str(episode_id)] = {
                "kind": kind,
                "title": title,
                "company": company_label(company_id),
                "lines": len(lines),
                "scene": scene_path.name,
            }
        return len(lines)

    def save_index(self, elapsed_seconds: float) -> None:
        (self.texts_dir / "index.json").write_text(
            json.dumps(
                {
                    "count": len(self._index),
                    "elapsed_seconds": round(elapsed_seconds, 1),
                    "episodes": self._index,
                },
                ensure_ascii=False,
                indent=2,
            ),
            encoding="utf-8",
        )
