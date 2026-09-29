"""Daily lesson (稽古) bulk play.

Flow (wds嵇古打挑战 HAR):

    POST /api/Lives/StartLesson            body: [CharacterBaseMasterId, LiveMasterId]
    POST /api/Lives/FinishAndValidate      same FinishLivePayload as normal lives

The daily lesson allowance is server-side: DailyLimit (IDataObject tag 109)
keeps DailyLessonTimes (used count, increments per play) and the server
refuses further plays once the allowance is exhausted.  Lesson characters
and their default party slots come from CharacterLesson (tag 39):

    [characterBaseMasterId, [[position, playerCharacterId]...],
     bestScore, leaderPosition, rewardReceivedHighScore]

The score payload is built from the real notation (like --real-chart lives)
so every play lands at the max result (101.0 / Grade 9 / All Perfect).
"""

from __future__ import annotations

import json
import os
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Callable

from . import codec
from .api import ApiError
from .lives import (
    build_chart_payload,
    encode_finish_request,
    parse_start_score_params,
    retire_live,
)
from .story import StorySession


@dataclass(frozen=True)
class LessonCharacter:
    character_base_id: int
    slots: list[list[Any]]  # [[position, playerCharacterId]...]
    best_score: int


@dataclass
class LessonResult:
    character_base_id: int
    status: str  # ok | error | exhausted
    detail: str = ""
    record: list[Any] | None = None


def _with_retry(fn: Callable[[], Any], attempts: int = 4, delay: float = 5.0) -> Any:
    import urllib.error

    for i in range(attempts):
        try:
            return fn()
        except (urllib.error.URLError, TimeoutError, OSError):
            if i == attempts - 1:
                raise
            time.sleep(delay)


def load_lesson_characters(
    session: StorySession,
) -> list[LessonCharacter]:
    """CharacterLesson entries (tag 39) -> the playable lesson characters."""
    payloads = session.get("/api/data/user")
    chars: list[LessonCharacter] = []
    for obj in payloads[1] if len(payloads) > 1 else []:
        if not isinstance(obj, list) or len(obj) < 2 or obj[0] != 39:
            continue
        d = obj[1]
        if (
            isinstance(d, list)
            and len(d) >= 3
            and isinstance(d[0], int)
            and isinstance(d[1], list)
        ):
            chars.append(
                LessonCharacter(
                    character_base_id=d[0],
                    slots=[
                        [x[0], x[1]]
                        for x in d[1]
                        if isinstance(x, list) and len(x) >= 2 and x[1] is not None
                    ],
                    best_score=int(d[2] or 0),
                )
            )
    chars.sort(key=lambda c: -c.best_score)
    return chars


def daily_lesson_used(session: StorySession) -> int | None:
    """DailyLimit (tag 109) -> DailyLessonTimes (used count)."""
    payloads = session.get("/api/data/user")
    for obj in payloads[1] if len(payloads) > 1 else []:
        if isinstance(obj, list) and len(obj) >= 2 and obj[0] == 109:
            d = obj[1]
            if isinstance(d, list) and len(d) >= 3 and isinstance(d[2], int):
                return d[2]
    return None


def play_lesson(
    session: StorySession,
    character: LessonCharacter,
    *,
    live_master_id: int = 18202,
    wait_margin: int = 30,
    notations_dir: str | os.PathLike[str] = "notations",
    progress: Callable[[LessonCharacter, str, str], None] | None = None,
) -> LessonResult:
    """StartLesson -> wait -> FinishAndValidate with a max-score payload."""

    def start() -> list[Any]:
        return _with_retry(
            lambda: session.post_bytes(
                "/api/Lives/StartLesson",
                codec.pack_request([character.character_base_id, live_master_id]),
            )
        )

    music_id = live_master_id // 100
    difficulty = live_master_id % 100
    chart_path = Path(notations_dir) / str(music_id) / f"{difficulty}.json"
    notes = json.loads(chart_path.read_text(encoding="utf-8"))
    from .notation import Note, count_scored_notes

    n = count_scored_notes([Note(**x) for x in notes])

    def finish(start_resp: list[Any]) -> list[Any]:
        params = parse_start_score_params(start_resp)
        duration = _music_duration(music_id)
        wait = duration + wait_margin
        if progress:
            progress(character, "playing", f"waiting {wait}s")
        time.sleep(wait)
        payload = build_chart_payload(
            n,
            params["total_status"],
            params["base_score_percentage"],
            params["difficulty_coefficient"],
        )
        return _with_retry(
            lambda: session.post_bytes(
                "/api/Lives/FinishAndValidate", encode_finish_request(payload)
            )
        )

    try:
        retire_live(session)
        start_resp = start()
    except ApiError as ex:
        detail = f"start:{ex.status}"
        if ex.status in (400, 403):
            body = getattr(ex, "body", b"")
            if b"lesson" in body.lower() or b"Lesson" in body:
                detail = "exhausted"
        if progress:
            progress(character, "error", detail)
        return LessonResult(character.character_base_id, "error", detail)

    try:
        resp = finish(start_resp)
    except ApiError as ex:
        detail = f"finish:{ex.status}"
        body = getattr(ex, "body", b"")
        if ex.status == 400 and (b"VAL001" in body or b"uActiveLive" in body):
            # the StartLesson did not create a live session (stale session
            # state); clear and retry the whole play once before giving up.
            if progress:
                progress(character, "retry", "session lost (VAL001), restarting")
            try:
                retire_live(session)
                start_resp = start()
                resp = finish(start_resp)
            except ApiError as ex2:
                detail = f"finish:{ex2.status} session-retry-failed"
                if progress:
                    progress(character, "error", detail)
                return LessonResult(character.character_base_id, "error", detail)
            except Exception as ex2:  # noqa: BLE001
                detail = f"exception:{type(ex2).__name__}:{ex2}"
                if progress:
                    progress(character, "error", detail)
                return LessonResult(character.character_base_id, "error", detail)
        else:
            if progress:
                progress(character, "error", detail)
            return LessonResult(character.character_base_id, "error", detail)

    tres = resp[1] if len(resp) > 1 else []
    rate = tres[13] if len(tres) > 13 else None
    lamp = tres[5] if len(tres) > 5 else None
    record = None
    for obj in resp[2] if len(resp) > 2 else []:
        if isinstance(obj, list) and obj and obj[0] == 24:
            record = codec.to_json_value(obj)
    result = LessonResult(
        character.character_base_id,
        "ok",
        f"rate={rate} lamp={lamp}",
        record=record,
    )
    if progress:
        progress(character, "ok", result.detail)
    return result


def _music_duration(music_id: int) -> int:
    base = Path("masterdata/tables")
    p = base / "MusicMaster.json"
    if not p.exists():
        return 120
    rows = json.loads(p.read_text(encoding="utf-8"))
    for r in rows:
        if r["Id"] == music_id:
            return int(r.get("MusicTimeSecond") or 120)
    return 120


def run_lessons(
    session: StorySession,
    *,
    live_master_id: int = 18202,
    wait_margin: int = 30,
    notations_dir: str | os.PathLike[str] = "notations",
    max_plays: int | None = None,
    progress_file: str | os.PathLike[str] = "lessons_progress.json",
) -> list[LessonResult]:
    """Play lessons with every lesson character until the server stops us."""
    chars = load_lesson_characters(session)
    if not chars:
        print("[-] no lesson characters found")
        return []
    used = daily_lesson_used(session)
    print(f"[*] lesson characters={len(chars)} used_today={used}")

    results: list[LessonResult] = []
    for character in chars:
        if max_plays and len(results) >= max_plays:
            break

        def report(c: LessonCharacter, status: str, detail: str) -> None:
            print(
                f"[{c.character_base_id}] {status:8s} "
                f"score={c.best_score:>10d} {detail}"
            )

        result = play_lesson(
            session,
            character,
            live_master_id=live_master_id,
            wait_margin=wait_margin,
            notations_dir=notations_dir,
            progress=report,
        )
        results.append(result)
        # re-read the used count to decide whether to continue
        used = daily_lesson_used(session)
        print(f"[*] used_today now={used}")
        if result.status != "ok":
            break
    return results
