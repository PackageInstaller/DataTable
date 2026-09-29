"""Download and decrypt the encrypted notation (chart) files.

Notation URL (served outside the Addressables catalogs):

    {static_content_url}/Notations/{musicId}/{difficulty}.enc

Wire format (IDA: DebugNotationFactory.LoadWebAsync -> CustomAesEncoder ->
BrotliCompressHelper -> Parse):

    .enc = [16-byte IV][AES-256-CBC/PKCS7 ciphertext]
            key  = UTF8("k8teTB%QH.v-hY+e)7wees8bxYSLQdAg")
            then Brotli decompress -> UTF-8 text
    text  = lines of "StartTickCount,EndTickCount,NoteType,Lane,Width,
                      GimmickType,GimmickValue"

NoteType / GimmickType are AppConst enums (see docs/protocol.md).
"""

from __future__ import annotations

import json
import os
import urllib.request
from dataclasses import dataclass
from pathlib import Path
from typing import Any

import brotli
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

from .api import EnvironmentResult


NOTATION_KEY = b"k8teTB%QH.v-hY+e)7wees8bxYSLQdAg"
USER_AGENT = "BestHTTP/2 v2.8.5"

NOTE_TYPES = {
    "None": 0, "Normal": 10, "Critical": 20, "Sound": 30, "SoundPurple": 31,
    "Scratch": 40, "Flick": 50, "HoldStart": 80, "CriticalHoldStart": 81,
    "ScratchHoldStart": 82, "ScratchCriticalHoldStart": 83, "Hold": 100,
    "CriticalHold": 101, "ScratchHold": 110, "ScratchCriticalHold": 111,
    "BlueTap": 200, "HoldEighth": 900,
}
GIMMICK_TYPES = {
    "None": 0, "JumpScratch": 1, "OneDirection": 2,
    "Split1": 11, "Split2": 12, "Split3": 13, "Split4": 14,
    "Split5": 15, "Split6": 16,
    "FullSplit1": 31, "FullSplit2": 32, "FullSplit3": 33,
    "FullSplit4": 34, "FullSplit5": 35, "FullSplit6": 36,
    "LightSplit1": 51, "LightSplit2": 52, "LightSplit3": 53,
    "LightSplit4": 54, "LightSplit5": 55, "LightSplit6": 56,
    "IgnoreSplit1": 71, "IgnoreSplit2": 72, "IgnoreSplit3": 73,
    "IgnoreSplit4": 74, "IgnoreSplit5": 75, "IgnoreSplit6": 76,
}


def _enum_value(name_or_number: str, table: dict[str, int]) -> int:
    s = name_or_number.strip()
    if s.isdigit() or (s.startswith("-") and s[1:].isdigit()):
        return int(s)
    if s in table:
        return table[s]
    raise ValueError(f"unknown enum value: {s}")


@dataclass(frozen=True)
class Note:
    start_tick: float
    end_tick: float
    note_type: int
    lane: int
    width: int
    gimmick_type: int
    gimmick_value: int

    @property
    def is_note(self) -> bool:
        return self.note_type != 0


def _http_get(url: str, timeout: int = 60) -> bytes:
    req = urllib.request.Request(url, headers={"user-agent": USER_AGENT})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return resp.read()


def decrypt_enc(data: bytes) -> str:
    """AES-CBC + Brotli -> chart text."""
    iv, ciphertext = data[:16], data[16:]
    cipher = Cipher(algorithms.AES(NOTATION_KEY), modes.CBC(iv))
    decryptor = cipher.decryptor()
    plain = decryptor.update(ciphertext) + decryptor.finalize()
    pad = plain[-1]
    if 1 <= pad <= 16:
        plain = plain[:-pad]
    return brotli.decompress(plain).decode("utf-8")


def parse_chart(text: str) -> list[Note]:
    """Parse the CSV lines into Note objects (skips blank lines)."""
    notes: list[Note] = []
    for line in text.splitlines():
        line = line.strip()
        if not line:
            continue
        parts = line.split(",")
        if len(parts) < 7:
            continue
        notes.append(
            Note(
                start_tick=float(parts[0]),
                end_tick=float(parts[1]),
                note_type=_enum_value(parts[2], NOTE_TYPES),
                lane=int(parts[3]),
                width=int(parts[4]),
                gimmick_type=_enum_value(parts[5], GIMMICK_TYPES),
                gimmick_value=int(parts[6]),
            )
        )
    return notes


def count_scored_notes(notes: list[Note]) -> int:
    """Game-exact scored-note count (IDA: Score._Initialize_b__16_0).

    N = notes with NoteType != 0, minus the ids returned by
    GameUtil.GetDuplicatedSoundNoteIds: among notes whose type is in
    {Sound(30), SoundPurple(31), Scratch(40), HoldEighth(900)} sharing the
    same (StartTickCount, Lane), the first note whose type is in {30, 31, 40}
    is dropped (it is a sound cue riding on a hold/scratch note).

    Verified on 182/2: all 39 sound notes pair with a HoldEighth at the same
    tick+lane, so N = 468 - 39 = 429 == the number of base blocks in the
    captured real play.  On 210/1 no such pairs exist, so N = 742 (the
    previously used "exclude every Sound" shortcut undercounted to 734).
    """
    dup_types = {30, 31, 40, 900}
    pick = {30, 31, 40}
    groups: dict[tuple[float, int], list[Note]] = {}
    for n in notes:
        if n.note_type in dup_types:
            groups.setdefault((n.start_tick, n.lane), []).append(n)
    excluded: set[tuple[float, int]] = set()
    for group in groups.values():
        if len(group) > 1:
            first = next((n for n in group if n.note_type in pick), None)
            if first is not None:
                excluded.add((first.start_tick, first.lane))
    return sum(
        1
        for n in notes
        if n.note_type != 0
        and not (n.note_type in pick and (n.start_tick, n.lane) in excluded)
    )


def fetch_chart(
    env: EnvironmentResult,
    music_id: int,
    difficulty: int,
) -> list[Note]:
    """Download + decrypt + parse one chart."""
    url = (
        f"{env.asset_url}/Notations/{music_id}/{difficulty}.enc"
    )
    return parse_chart(decrypt_enc(_http_get(url)))


def download_charts(
    env: EnvironmentResult,
    *,
    out_dir: str | os.PathLike[str] = "notations",
    music_ids: list[int] | None = None,
    difficulties: list[int] | None = None,
) -> dict[str, Any]:
    """Download/decrypt/parse every chart into JSON files."""
    from .lives import load_lives

    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    lives = load_lives()
    if music_ids:
        lives = [lp for lp in lives if lp.music_id in music_ids]
    if difficulties:
        lives = [lp for lp in lives if lp.difficulty in difficulties]

    summary: dict[str, Any] = {}
    for lp in lives:
        try:
            notes = fetch_chart(env, lp.music_id, lp.difficulty)
            dest = out / str(lp.music_id) / f"{lp.difficulty}.json"
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.write_text(
                json.dumps(
                    [n.__dict__ for n in notes],
                    ensure_ascii=False,
                    indent=2,
                ),
                encoding="utf-8",
            )
            note_count = sum(1 for n in notes if n.is_note)
            summary[f"{lp.music_id}/{lp.difficulty}"] = {
                "lines": len(notes),
                "notes": note_count,
            }
            print(
                f"[{lp.music_id:>5}/{lp.difficulty}] lines={len(notes)} "
                f"notes={note_count}"
            )
        except Exception as ex:  # noqa: BLE001
            summary[f"{lp.music_id}/{lp.difficulty}"] = {
                "error": f"{type(ex).__name__}: {ex}"
            }
            print(f"[{lp.music_id:>5}/{lp.difficulty}] ERROR {ex}")
    (out / "summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    return summary


def build_notation_index(
    asset_url: str,
    *,
    masterdata_dir: str | os.PathLike[str] = "masterdata/tables",
    notations_dir: str | os.PathLike[str] = "notations",
) -> dict[str, Any]:
    """Song/chart index with public .enc URLs (shareable, like episode_trusted.json).

    The Notation CDN container is anonymously readable (verified), so anyone
    can download a chart from {asset_url}/Notations/{music}/{difficulty}.enc
    with the decryption info included below.
    """
    base = Path(masterdata_dir)
    music = json.loads((base / "MusicMaster.json").read_text(encoding="utf-8"))
    lives = json.loads((base / "LiveMaster.json").read_text(encoding="utf-8"))
    summary_path = Path(notations_dir) / "summary.json"
    summary: dict[str, Any] = {}
    if summary_path.exists():
        summary = json.loads(summary_path.read_text(encoding="utf-8"))

    by_music: dict[int, list[dict[str, Any]]] = {}
    for r in lives:
        by_music.setdefault(r["MusicMasterId"], []).append(r)

    songs: list[dict[str, Any]] = []
    for m in sorted(music, key=lambda r: r["Id"]):
        charts: list[dict[str, Any]] = []
        for lv in sorted(by_music.get(m["Id"], []), key=lambda r: r["Difficulty"]):
            counts = summary.get(f"{m['Id']}/{lv['Difficulty']}", {})
            charts.append(
                {
                    "difficulty": lv["Difficulty"],
                    "live_id": lv["Id"],
                    "level": lv["Level"],
                    "unlock_condition": lv.get("UnlockCondition"),
                    "unlock_value": lv.get("UnlockValue"),
                    "start_date": lv.get("StartDate"),
                    "end_date": lv.get("EndDate"),
                    "url": (
                        f"{asset_url.rstrip('/')}/Notations/"
                        f"{m['Id']}/{lv['Difficulty']}.enc"
                    ),
                    "lines": counts.get("lines"),
                    "notes": counts.get("notes"),
                }
            )
        songs.append(
            {
                "music_id": m["Id"],
                "name": m.get("Name"),
                "pronounce": m.get("PronounceName"),
                "lyric_writer": m.get("LyricWriter"),
                "composer": m.get("Composer"),
                "arranger": m.get("Arranger"),
                "duration_seconds": m.get("MusicTimeSecond"),
                "released_at": m.get("ReleasedAt"),
                "vocal_versions": m.get("VocalVersions"),
                "charts": charts,
            }
        )

    return {
        "description": (
            "World Dai Star (ユメステ) song chart index. Chart files are "
            "publicly downloadable from the Notation CDN without auth."
        ),
        "asset_url": asset_url.rstrip("/"),
        "format": {
            "chart_file": "{asset_url}/Notations/{music_id}/{difficulty}.enc",
            "music_config_file": "{asset_url}/Notations/{music_id}/music_config.enc",
            "chart_encryption": {
                "algorithm": "AES-256-CBC/PKCS7",
                "key": "k8teTB%QH.v-hY+e)7wees8bxYSLQdAg",
                "iv": "first 16 bytes of the file",
                "then": "Brotli decompress -> UTF-8 text",
            },
            "music_config_encryption": {
                "algorithm": "AES-256-CBC/PKCS7",
                "key": "X)|9Vs+&AB5qKBrzqWq)quqEjFug8LaK",
                "then": "UTF-8 text (no Brotli)",
            },
            "line_format": (
                "StartTickCount,EndTickCount,NoteType,Lane,Width,"
                "GimmickType,GimmickValue"
            ),
            "note_types": NOTE_TYPES,
            "gimmick_types": GIMMICK_TYPES,
        },
        "song_count": len(songs),
        "chart_count": sum(len(s["charts"]) for s in songs),
        "songs": songs,
    }
