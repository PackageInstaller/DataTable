"""Bulk live playback: Start -> wait (song length) -> FinishAndValidate.

Wire format (verified against wds_打歌.har + the raw body the user captured):

  * POST /api/Lives/Start with a plain msgpack StartLivePayload:
        [PartyId, LiveMasterId, None, None, UseStamina, 1, 1,
         False, False, None, None, None, 0, None, None]
    UseStamina=false still grants the full clear rewards (tested).

  * POST /api/Lives/FinishAndValidate with an ext-98 LZ4 envelope containing
    the FinishLivePayload:
        [0, 0, None, False, BaseScoreBlock[], [], [], [], None, [0]]
    The client leaves Score/MaxCombo/Judges/IsCleared empty; the server
    derives everything from the score blocks.  Each BaseScoreBlock is
        [Hash, Score, Life, NoteId, TimingType, Combo]
    with the additive hash chain (IDA):
        Hash[i] = Hash[i-1] + Score + Life + NoteId + Timing + Combo
    The server does NOT validate the note count, note ids, per-note scores,
    or timing values (any plausible all-perfect payload is accepted).

  * The server validates liveSpanSeconds (time between Start and Finish)
    against the song length: a 165 s song rejected a 120 s wait and accepted
    170 s.  This module waits MusicTimeSecond + margin.

Results (all-perfect lamp, capped achievement rate) are recorded server-side
per live; the module tracks its own progress in a JSON file so it can resume.
"""

from __future__ import annotations

import json
import os
import datetime
import random
import time
import urllib.error
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Callable

from . import codec
from .api import ApiClient, ApiError
from .story import StorySession


@dataclass(frozen=True)
class LivePlan:
    live_id: int
    music_id: int
    difficulty: int
    level: int
    duration_seconds: int
    music_name: str


@dataclass
class LiveResult:
    live_id: int
    status: str  # ok | locked | error
    detail: str = ""
    rewards: list[Any] | None = None
    record: list[Any] | None = None


def load_lives(
    masterdata_dir: str | os.PathLike[str] = "masterdata/tables",
) -> list[LivePlan]:
    """All released lives ordered by (music id, difficulty ascending)."""
    base = Path(masterdata_dir)

    def rows(name: str) -> list[dict[str, Any]]:
        p = base / f"{name}.json"
        if not p.exists():
            return []
        return json.loads(p.read_text(encoding="utf-8"))

    music = {r["Id"]: r for r in rows("MusicMaster")}
    lives: list[LivePlan] = []
    for r in rows("LiveMaster"):
        m = music.get(r["MusicMasterId"])
        if not m:
            continue
        start = r.get("StartDate") or ""
        end = r.get("EndDate") or ""
        now = datetime.datetime.now(datetime.timezone.utc).isoformat()
        # skip lives not yet released
        if start and start > now:
            continue
        lives.append(
            LivePlan(
                live_id=r["Id"],
                music_id=r["MusicMasterId"],
                difficulty=r.get("Difficulty") or 1,
                level=r.get("Level") or 0,
                duration_seconds=m.get("MusicTimeSecond") or 90,
                music_name=m.get("Name") or "",
            )
        )
    lives.sort(key=lambda lp: (lp.music_id, lp.difficulty))
    return lives


def build_finish_payload(
    note_count: int = 500,
    score_per_note: int = 100000,
    timing: int = 6,
) -> list[Any]:
    """All-perfect FinishLivePayload with a valid additive hash chain.

    The server caps the recorded achievement rate at 101.0 with grade 9
    (top) and ClearLamp 6 (All Perfect); large per-note scores reliably hit
    that cap regardless of the real chart, so no chart data is required.
    """
    blocks: list[list[int]] = []
    prev = 0
    for i in range(1, note_count + 1):
        score = score_per_note
        life = 1000
        note_id = i
        combo = i
        h = prev + score + life + note_id + timing + combo
        blocks.append([h, score, life, note_id, timing, combo])
        prev = h
    return [0, 0, None, False, blocks, [], [], [], None, [0]]


def parse_start_score_params(response: list[Any]) -> dict[str, float]:
    """Extract scoring params from the Start response.

    Count (max score) = difficultyCoefficient * 10 * totalStatus
                        * (baseScorePercentage + 100) / 100

    Verified against the captured 210/1 play: 0.95 * 10 * 924769 * 1.23
    = 10,805,925.76 == the captured payload's total score (10,805,925).
    """
    tres = response[1] if len(response) > 1 else []
    return {
        "total_status": float(tres[5] or 0) if len(tres) > 5 else 0.0,
        "base_score_percentage": float(tres[9] or 0) if len(tres) > 9 else 0.0,
        "difficulty_coefficient": float(tres[10] or 1.0) if len(tres) > 10 else 1.0,
    }


def build_chart_payload(
    note_count: int,
    total_status: float,
    base_score_percentage: float,
    difficulty_coefficient: float,
    *,
    timing: int = 6,
) -> list[Any]:
    """All-PERFECT_STAR payload matching the game's score model.

    PERFECT_STAR contributes 1.01/N to the achievement rate per note
    (Score._Initialize_b__16_0: 101/N with 2-digit decimal scale), so the
    per-note added score follows the 4-decimal floor of the cumulative rate:

        added_i = Count * (floor(i*1.01/N*10000) - floor((i-1)*1.01/N*10000))/10000
    """
    n = max(1, note_count)
    count = (
        difficulty_coefficient
        * 10.0
        * total_status
        * (base_score_percentage + 100.0)
        / 100.0
    )
    blocks: list[list[int]] = []
    prev = 0
    prev_rate = 0.0
    for i in range(1, n + 1):
        rate = i * 1.01 / n
        rounded = int(rate * 10000) / 10000
        score = round(count * (rounded - prev_rate))
        prev_rate = rounded
        h = prev + score + 1000 + i + timing + i
        blocks.append([h, score, 1000, i, timing, i])
        prev = h
    return [0, 0, None, False, blocks, [], [], [], None, [0]]


def encode_finish_request(payload: list[Any]) -> bytes:
    return codec.encode_lz4_frame(codec.pack_request(payload))


def start_live(
    session: StorySession,
    party_id: int,
    live_id: int,
    *,
    use_stamina: bool = False,
    stamina_ratio: int = 1,
) -> list[Any]:
    payload = [
        party_id, live_id, None, None, use_stamina, stamina_ratio, 1,
        False, False, None, None, None, 0, None, None,
    ]
    return session.post_bytes("/api/Lives/Start", codec.pack_request(payload))


def retire_live(session: StorySession) -> None:
    try:
        session.post_bytes("/api/Lives/Retire", b"")
    except (ApiError, urllib.error.URLError):
        pass


def finish_live(
    session: StorySession,
    payload: list[Any],
) -> list[Any]:
    return session.post_bytes(
        "/api/Lives/FinishAndValidate", encode_finish_request(payload)
    )


def parse_finish_response(
    response: list[Any],
) -> tuple[Any, Any, list[Any] | None, list[Any] | None]:
    tres = response[1] if len(response) > 1 else []
    rate = tres[13] if len(tres) > 13 else None
    lamp = tres[5] if len(tres) > 5 else None
    rewards = tres[23] if len(tres) > 23 else None
    record = None
    for obj in response[2] if len(response) > 2 else []:
        if isinstance(obj, list) and obj and obj[0] == 24:
            record = codec.to_json_value(obj)
    return (rate, lamp, rewards, record)


def current_party_id(session: StorySession) -> int | None:
    payloads = session.get("/api/data/user")
    for obj in payloads[1] if len(payloads) > 1 else []:
        if isinstance(obj, list) and obj and obj[0] == 2:
            data = obj[1]
            if isinstance(data, list) and len(data) > 1:
                return int(data[1])
    return None


def load_party_ids(session: StorySession, count: int = 4) -> list[int]:
    """First `count` preset parties by order (tag 6: [id, order, name, ...]).

    The game's party list is ordered 0..11 (天狼星/電姫/銀河座/Eden/...), so
    `count=4` returns the "1-4队" the user can pick from for each live.
    """
    payloads = session.get("/api/data/user")
    parties: list[tuple[int, int]] = []
    for obj in payloads[1] if len(payloads) > 1 else []:
        if (
            isinstance(obj, list)
            and obj
            and obj[0] == 6
            and isinstance(obj[1], list)
            and len(obj[1]) >= 2
            and isinstance(obj[1][0], int)
            and isinstance(obj[1][1], int)
        ):
            parties.append((obj[1][1], obj[1][0]))
    parties.sort()
    return [pid for _, pid in parties[:count]]


def play_one(
    session: StorySession,
    plan: LivePlan,
    party_id: int,
    *,
    wait_margin: int = 30,
    note_count: int = 500,
    real_chart: bool = False,
    notations_dir: str | os.PathLike[str] = "notations",
    use_stamina: bool = False,
    stamina_ratio: int = 1,
    progress: Callable[[LivePlan, str, str], None] | None = None,
) -> LiveResult:
    try:
        retire_live(session)
        try:
            start_response = _with_retry(
                lambda: start_live(
                    session,
                    party_id,
                    plan.live_id,
                    use_stamina=use_stamina,
                    stamina_ratio=stamina_ratio,
                )
            )
        except ApiError as ex:
            detail = f"start:{ex.status}"
            if ex.status in (400, 403):
                detail = "locked"
            if progress:
                progress(plan, "locked", detail)
            return LiveResult(plan.live_id, "locked", detail)

        wait = plan.duration_seconds + wait_margin
        if progress:
            progress(plan, "playing", f"waiting {wait}s")
        time.sleep(wait)

        if real_chart:
            params = parse_start_score_params(start_response)
            chart_path = (
                Path(notations_dir) / str(plan.music_id) / f"{plan.difficulty}.json"
            )
            if not chart_path.exists():
                raise RuntimeError(f"chart not downloaded: {chart_path}")
            notes = json.loads(chart_path.read_text(encoding="utf-8"))
            # N = game-exact scored note count (duplicated sound cues only).
            from .notation import Note, count_scored_notes

            n = count_scored_notes([Note(**x) for x in notes])
            payload = build_chart_payload(
                n,
                params["total_status"],
                params["base_score_percentage"],
                params["difficulty_coefficient"],
            )
        else:
            payload = build_finish_payload(note_count=note_count)
        try:
            response = _with_retry(lambda: finish_live(session, payload))
            rate, lamp, rewards, record = parse_finish_response(response)
            result = LiveResult(
                plan.live_id,
                "ok",
                f"rate={rate} lamp={lamp}",
                rewards=rewards,
                record=record,
            )
            if progress:
                progress(plan, "ok", result.detail)
            return result
        except ApiError as ex:
            detail = f"finish:{ex.status}"
            if ex.status in (400, 403):
                detail = "locked"
            if progress:
                progress(plan, "error", detail)
            return LiveResult(plan.live_id, "error", detail)
    except Exception as ex:  # noqa: BLE001 - keep the whole run alive
        detail = _status_of(ex)
        if progress:
            progress(plan, "error", detail)
        return LiveResult(plan.live_id, "error", detail)


def run_lives(
    session: StorySession,
    plans: list[LivePlan],
    *,
    party_id: int | None = None,
    random_party: bool = False,
    party_pool: int = 4,
    wait_margin: int = 30,
    note_count: int = 500,
    real_chart: bool = False,
    notations_dir: str | os.PathLike[str] = "notations",
    progress_file: str | os.PathLike[str] = "lives_progress.json",
    resume: bool = True,
    delay: float = 1.0,
    on_result: Callable[[LiveResult], None] | None = None,
) -> list[LiveResult]:
    """Play every plan sequentially, persisting progress for resume."""
    pool: list[int] = []
    if random_party:
        pool = load_party_ids(session, party_pool)
        if not pool:
            raise RuntimeError("cannot load preset parties")
        print(f"[*] random party pool: {pool}")
    elif party_id is None:
        party_id = current_party_id(session)
    if not party_id and not pool:
        raise RuntimeError("cannot determine current party id")

    state: dict[str, Any] = {}
    if resume and Path(progress_file).exists():
        state = json.loads(Path(progress_file).read_text(encoding="utf-8"))
    state.setdefault("lives", {})

    results: list[LiveResult] = []
    for plan in plans:
        chosen = random.choice(pool) if pool else party_id
        key = str(plan.live_id)
        saved = state["lives"].get(key)
        saved_status = (
            saved.get("status") if isinstance(saved, dict) else saved
        )
        if resume and saved_status == "ok":
            continue

        def report(p: LivePlan, status: str, detail: str) -> None:
            print(
                f"[{p.music_id:>5}/{p.difficulty}] party={chosen} {status:7s} "
                f"{p.music_name[:24]:24s} {detail}"
            )

        result = play_one(
            session, plan, chosen,
            wait_margin=wait_margin,
            note_count=note_count,
            real_chart=real_chart,
            notations_dir=notations_dir,
            progress=report,
        )
        if result.status == "error" and result.detail.startswith("exception"):
            # transient failure: retry the live once before giving up
            time.sleep(5)
            result = play_one(
                session, plan, chosen,
                wait_margin=wait_margin,
                note_count=note_count,
                real_chart=real_chart,
                notations_dir=notations_dir,
                progress=report,
            )
        results.append(result)
        state["lives"][key] = {
            "status": result.status,
            "detail": result.detail,
            "record": result.record,
        }
        Path(progress_file).write_text(
            json.dumps(state, ensure_ascii=False, indent=2),
            encoding="utf-8",
        )
        if on_result:
            on_result(result)
        if delay:
            time.sleep(delay)
    return results


def summarize(results: list[LiveResult]) -> str:
    counts: dict[str, int] = {}
    for r in results:
        counts[r.status] = counts.get(r.status, 0) + 1
    return json.dumps(counts, ensure_ascii=False)


def _status_of(exc: BaseException) -> str:
    return f"exception:{type(exc).__name__}:{exc}"


def _with_retry(fn: Callable[[], Any], attempts: int = 4, delay: float = 5.0) -> Any:
    """Retry transient network failures (SSL drops etc.)."""
    for i in range(attempts):
        try:
            return fn()
        except urllib.error.URLError:
            if i == attempts - 1:
                raise
            time.sleep(delay)
