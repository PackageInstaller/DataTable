"""Audition (オーディション / challenge floors) bulk clear.

The game's challenge tower is the Audition list: 220 released floors
(AuditionMaster 1-220; 221-250 unlock later), each with 2-3 phases
(AuditionPhaseMaster): phase 1/2 need only ClearScore, phase 3 adds a
StarActCount requirement.

Progress is read from:

    GET /api/Auditions/{id}?auditionId={id}
    -> PartiesPhases: one entry per phase = [Parties ([] = not cleared), Phase]

Playing a phase uses the normal live flow with AuditionMasterId set in
StartLivePayload, then FinishAndValidate with blocks whose total score is
ClearScore + a random amount (<= 1,000,000); phase 3 payloads additionally
carry StarActCount StarActScoreBlocks.
"""

from __future__ import annotations

import json
import os
import random
import datetime
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Callable

from . import codec
from .api import ApiError
from .lives import encode_finish_request, retire_live
from .story import StorySession


@dataclass(frozen=True)
class AuditionPhase:
    phase: int
    clear_score: int
    star_act_count: int | None


@dataclass(frozen=True)
class AuditionInfo:
    audition_id: int
    music_id: int
    max_phase: int
    phases: list[AuditionPhase]
    best_cleared: int
    skipped: bool = False

    @property
    def released(self) -> bool:
        return self.max_phase > 0

    @property
    def fully_cleared(self) -> bool:
        return self.skipped or self.best_cleared >= self.max_phase


@dataclass
class AuditionResult:
    audition_id: int
    phase: int
    status: str  # ok | error
    detail: str = ""
    before_phase: int = 0
    after_phase: int = 0


def _with_retry(fn: Callable[[], Any], attempts: int = 4, delay: float = 5.0) -> Any:
    import urllib.error

    for i in range(attempts):
        try:
            return fn()
        except (urllib.error.URLError, TimeoutError, OSError):
            if i == attempts - 1:
                raise
            time.sleep(delay)


def _load_master() -> tuple[
    dict[int, int], dict[int, list[AuditionPhase]], dict[int, str]
]:
    base = Path("masterdata/tables")
    am = json.loads((base / "AuditionMaster.json").read_text(encoding="utf-8"))
    ap = json.loads((base / "AuditionPhaseMaster.json").read_text(encoding="utf-8"))
    music: dict[int, int] = {}
    starts: dict[int, str] = {}
    phases: dict[int, list[AuditionPhase]] = {}
    for r in am:
        music[r["Id"]] = r.get("MusicMasterId") or 0
        starts[r["Id"]] = r.get("DisplayStartAt") or ""
    _AUDITION_SENSE_NOTATION: dict[int, int] = {
        r["Id"]: r.get("SenseNotationMasterId") or 0 for r in am
    }
    for r in ap:
        aid = r["AuditionasterId"]
        phases.setdefault(aid, []).append(
            AuditionPhase(
                phase=r["Phase"],
                clear_score=int(r.get("ClearScore") or 0),
                star_act_count=r.get("StarActCount"),
            )
        )
    for v in phases.values():
        v.sort(key=lambda p: p.phase)
    return music, phases, starts


_SENSE_TIMES_CACHE: dict[int, list[int]] = {}


def sense_event_times(audition_id: int) -> list[int]:
    """Star-act / sense event seconds for an audition floor.

    AuditionMaster.SenseNotationMasterId -> SenseNotationMaster.Details
    ([senseId, memberPosition, timeSeconds]); the captured real audition play
    sent its sense/star blocks exactly at these times (verified for audition
    161: 3/21/43/52/77/98).  Star-act phases (StarActCount) are credited only
    for star blocks at valid event times, so fabricated seconds (30*i) never
    advance the phase.
    """
    if audition_id in _SENSE_TIMES_CACHE:
        return _SENSE_TIMES_CACHE[audition_id]
    am = json.loads(
        Path("masterdata/tables/AuditionMaster.json").read_text(encoding="utf-8")
    )
    sm = json.loads(
        Path("masterdata/tables/SenseNotationMaster.json").read_text(encoding="utf-8")
    )
    sense_id = next(
        (r.get("SenseNotationMasterId") or 0 for r in am if r["Id"] == audition_id),
        0,
    )
    times: list[int] = []
    if sense_id:
        for r in sm:
            if r["Id"] == sense_id:
                times = sorted({int(d[2]) for d in (r.get("Details") or [])})
                break
    _SENSE_TIMES_CACHE[audition_id] = times
    return times


def fetch_audition(session: StorySession, audition_id: int) -> list[Any] | None:
    try:
        return session.get(f"/api/Auditions/{audition_id}?auditionId={audition_id}")
    except ApiError as ex:
        if ex.status in (400, 403, 404):
            return None
        raise


def _user_clears(session: StorySession) -> dict[int, tuple[int, int]]:
    """Own cleared phases from /api/data/user tag 90 (AuditionClear).

    [Id, AuditionMasterId, ClearPhase, ObsoletePartyId, ObsoleteUserId,
     SkipClearPhase].  This is the account's real progress; the
    /api/Auditions/{id} endpoint only returns the global high-score parties
    (other players' clears), which must NOT be used for star progress.
    """
    payloads = session.get("/api/data/user")
    clears: dict[int, tuple[int, int]] = {}
    for obj in payloads[1] if len(payloads) > 1 else []:
        if not isinstance(obj, list) or len(obj) < 2 or obj[0] != 90:
            continue
        d = obj[1]
        if not isinstance(d, list) or len(d) < 3 or not isinstance(d[1], int):
            continue
        phase = int(d[2] or 0)
        skip = int(d[5]) if len(d) > 5 and d[5] is not None else 0
        prev_phase, prev_skip = clears.get(d[1], (0, 0))
        clears[d[1]] = (max(prev_phase, phase), max(prev_skip, skip))
    return clears


def load_auditions(
    session: StorySession,
    audition_ids: list[int] | None = None,
) -> list[AuditionInfo]:
    """Audition list with the account's own cleared phases (tag 90)."""
    music, phases, starts = _load_master()
    ids = audition_ids or sorted(music)
    infos: list[AuditionInfo] = []
    now = datetime.datetime.now(datetime.timezone.utc).isoformat()
    clears = _user_clears(session)
    for aid in ids:
        start = starts.get(aid) or ""
        if start and start > now:
            # not released yet (e.g. floors 221-250 open 2026-08-19)
            infos.append(
                AuditionInfo(
                    audition_id=aid,
                    music_id=music.get(aid, 0),
                    max_phase=0,
                    phases=[],
                    best_cleared=0,
                    skipped=False,
                )
            )
            continue
        ph = phases.get(aid, [])
        best, skip = clears.get(aid, (0, 0))
        infos.append(
            AuditionInfo(
                audition_id=aid,
                music_id=music.get(aid, 0),
                max_phase=max((p.phase for p in ph), default=0),
                phases=ph,
                best_cleared=best,
                skipped=skip > 0,
            )
        )
    return infos


def build_score_payload(
    note_count: int,
    target_score: int,
    *,
    star_act_count: int = 0,
    star_times: list[int] | None = None,
    sense_count: int = 0,
    timing: int = 6,
) -> list[Any]:
    """Blocks whose total equals target_score.

    Star-act phases additionally carry StarActScoreBlocks; sense blocks are
    included to mirror a real play (chains start at 0 for star acts and at
    -2000 for sense blocks, per the captured lesson payload).
    """
    n = max(1, note_count)
    per_note = target_score // n
    remainder = target_score - per_note * n
    blocks: list[list[int]] = []
    prev = 0
    for i in range(1, n + 1):
        score = per_note + (remainder if i == n else 0)
        h = prev + score + 1000 + i + timing + i
        blocks.append([h, score, 1000, i, timing, i])
        prev = h

    star_blocks: list[list[int]] = []
    if star_act_count > 0:
        # valid trigger times come from the audition's sense notation; fall
        # back to the chart's elapsed seconds only if the table is missing.
        times = star_times or []
        if not times and star_act_count > 0:
            times = [int(30 + 30 * i) for i in range(star_act_count)]
        prev = 0
        for i, second in enumerate(times, start=1):
            score = 33_000_000 + i * 1_000_000
            life = 1000
            combo = 100 + i * 50
            h = prev + score + life + second + combo
            star_blocks.append([h, score, life, second, combo])
            prev = h

    sense_blocks: list[list[int]] = []
    if sense_count > 0:
        prev = -2000
        sense_id = 18288104600
        for i in range(1, sense_count + 1):
            score = 6_000_000
            life = 1000
            second = 15 * i
            combo = 40 + i
            h = prev + score + life + second + sense_id + combo
            sense_blocks.append([h, score, life, second, sense_id, combo])
            prev = h

    return [0, 0, None, False, blocks, sense_blocks, star_blocks, [], None, [0]]


def play_audition_phase(
    session: StorySession,
    info: AuditionInfo,
    phase: AuditionPhase,
    *,
    party_id: int,
    difficulty: int = 3,
    wait_margin: int = 30,
    notations_dir: str | os.PathLike[str] = "notations",
    random_ceiling: int = 1_000_000,
    progress: Callable[[AuditionInfo, AuditionPhase, str, str], None] | None = None,
) -> AuditionResult:
    chart_path = Path(notations_dir) / str(info.music_id) / f"{difficulty}.json"
    if not chart_path.exists():
        # fall back to a fixed note count without the chart
        note_count = 400 + difficulty * 100
    else:
        notes = json.loads(chart_path.read_text(encoding="utf-8"))
        note_count = sum(1 for x in notes if x.get("note_type", 0) not in (0, 30))

    target = phase.clear_score + random.randint(0, random_ceiling)
    duration = _music_duration(info.music_id)

    def start() -> None:
        live_master_id = info.music_id * 100 + difficulty
        start_payload = [
            party_id, live_master_id, info.audition_id, None, False, 1, 1,
            False, False, None, None, None, 0, None, None,
        ]
        _with_retry(
            lambda: session.post_bytes(
                "/api/Lives/Start", codec.pack_request(start_payload)
            )
        )

    def finish() -> list[Any]:
        if progress:
            progress(
                info, phase, "playing",
                f"score>={phase.clear_score} target={target} wait={duration + wait_margin}s",
            )
        time.sleep(duration + wait_margin)
        payload = build_score_payload(
            note_count,
            target,
            star_act_count=phase.star_act_count or 0,
            star_times=(
                sense_event_times(info.audition_id)
                if phase.star_act_count
                else None
            ),
        )
        return _with_retry(
            lambda: session.post_bytes(
                "/api/Lives/FinishAndValidate", encode_finish_request(payload)
            )
        )

    stage = "start"
    try:
        retire_live(session)
        start()
        stage = "finish"
        try:
            resp = finish()
        except ApiError as ex:
            body = getattr(ex, "body", b"")
            if ex.status == 400 and (b"VAL001" in body or b"uActiveLive" in body):
                # stale session: clear and retry the whole play once
                if progress:
                    progress(info, phase, "retry", "session lost (VAL001)")
                retire_live(session)
                start()
                resp = finish()
            else:
                raise
    except ApiError as ex:
        detail = f"{stage}:{ex.status}"
        if progress:
            progress(info, phase, "error", detail)
        return AuditionResult(info.audition_id, phase.phase, "error", detail)
    except Exception as ex:  # noqa: BLE001
        detail = f"exception:{type(ex).__name__}:{ex}"
        if progress:
            progress(info, phase, "error", detail)
        return AuditionResult(info.audition_id, phase.phase, "error", detail)

    tres = resp[1] if len(resp) > 1 else []
    before = tres[9] if len(tres) > 9 else 0
    after = tres[10] if len(tres) > 10 else 0
    status = "ok" if after > before else "error"
    detail = f"phase {before}->{after} rate={tres[13] if len(tres) > 13 else None}"
    if progress:
        progress(info, phase, status, detail)
    return AuditionResult(
        info.audition_id, phase.phase, status, detail, before, after
    )


def run_auditions(
    session: StorySession,
    *,
    audition_ids: list[int] | None = None,
    party_id: int | None = None,
    difficulty: int = 3,
    wait_margin: int = 30,
    notations_dir: str | os.PathLike[str] = "notations",
    random_ceiling: int = 1_000_000,
    progress_file: str | os.PathLike[str] = "auditions_progress.json",
    skip_star_phases: bool = False,
) -> list[AuditionResult]:
    """Clear every uncleared phase of every released audition."""
    from .lives import current_party_id

    if party_id is None:
        party_id = current_party_id(session)
    if not party_id:
        raise RuntimeError("cannot determine party id")

    infos = load_auditions(session, audition_ids)
    todo = [i for i in infos if i.released and not i.fully_cleared]
    print(f"[*] auditions={len(infos)} uncleared={len(todo)}")
    results: list[AuditionResult] = []
    done: dict[str, Any] = {}
    if Path(progress_file).exists():
        try:
            done = json.loads(Path(progress_file).read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            done = {}
    for info in todo:
        for phase in info.phases:
            if phase.phase <= info.best_cleared:
                continue
            key = f"{info.audition_id}/p{phase.phase}"
            if done.get(key, {}).get("status") == "ok":
                continue
            if skip_star_phases and phase.star_act_count:
                print(
                    f"[{info.audition_id}/p{phase.phase}] skipped   "
                    f"3-star (StarActCount={phase.star_act_count})"
                )
                continue

            def report(
                i: AuditionInfo, p: AuditionPhase, status: str, detail: str
            ) -> None:
                print(
                    f"[{i.audition_id}/p{p.phase}] {status:6s} "
                    f"score>={p.clear_score} {detail}"
                )

            result = play_audition_phase(
                session,
                info,
                phase,
                party_id=party_id,
                difficulty=difficulty,
                wait_margin=wait_margin,
                notations_dir=notations_dir,
                random_ceiling=random_ceiling,
                progress=report,
            )
            results.append(result)
            done[key] = {
                "status": result.status,
                "detail": result.detail,
                "before": result.before_phase,
                "after": result.after_phase,
            }
            Path(progress_file).write_text(
                json.dumps(done, ensure_ascii=False, indent=2),
                encoding="utf-8",
            )
            if result.status == "ok":
                info = AuditionInfo(
                    info.audition_id, info.music_id, info.max_phase,
                    info.phases, phase.phase,
                )
    return results


def _music_duration(music_id: int) -> int:
    p = Path("masterdata/tables/MusicMaster.json")
    if not p.exists():
        return 120
    rows = json.loads(p.read_text(encoding="utf-8"))
    for r in rows:
        if r["Id"] == music_id:
            return int(r.get("MusicTimeSecond") or 120)
    return 120
