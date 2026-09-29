"""Daily automation: 10x-stamina live plays, story unlock scan, day rollover.

One daily cycle (game day resets at 04:00 Asia/Shanghai = 05:00 JST):

  1. on a new game day: force a fresh Bearer, claim daily freebies
     (circle theater stamina, login bonus, free market frames);
  2. play lives with 10x stamina consumption (UseStamina + ratio 10);
  3. after every song, scan the story tables for newly unlockable episodes
     and unlock/read them;
  4. run daily lessons (稽古) until the server says exhausted;
  5. claim all Daily mission rewards.

`--wait-day` keeps the process alive until the next 04:00 CST boundary and
repeats.
"""

from __future__ import annotations

import json
import os
import time
from dataclasses import dataclass
from datetime import datetime, timedelta, timezone
from pathlib import Path
from typing import Any
from zoneinfo import ZoneInfo

import msgpack

from .api import ApiError
from .lives import LivePlan, play_one
from .story import (
    StorySession,
    fetch_user_state,
    get_episode_details,
    load_episodes,
    read_episode,
    release_side_story,
)


DAY_RESET_HOUR = 4  # Asia/Shanghai
CST = ZoneInfo("Asia/Shanghai")
STATE_FILE = "daily_state.json"


def game_day_id(now: datetime | None = None) -> str:
    """Game-day id: the calendar date that starts at 04:00 CST."""
    now = now or datetime.now(CST)
    return (now - timedelta(hours=DAY_RESET_HOUR)).date().isoformat()


def next_day_boundary(now: datetime | None = None) -> datetime:
    now = now or datetime.now(CST)
    today = now.replace(
        hour=DAY_RESET_HOUR, minute=0, second=0, microsecond=0
    )
    return today if now < today else today + timedelta(days=1)


def fetch_stamina(session: StorySession) -> tuple[int, int]:
    """(current, max) stamina from /api/data/user tag 0 + PlayerRankMaster."""
    payloads = session.get("/api/data/user")
    current = 0
    rank = 0
    for obj in payloads[1] if len(payloads) > 1 else []:
        if isinstance(obj, list) and obj and obj[0] == 0 and len(obj[1]) > 3:
            d = obj[1]
            rank = int(d[1] or 0)
            current = int(d[3] or 0)
            break
    max_stamina = 0
    base = Path("masterdata/tables")
    pr = base / "PlayerRankMaster.json"
    if pr.exists():
        for r in json.loads(pr.read_text(encoding="utf-8")):
            if r.get("Rank") == rank:
                max_stamina = int(r.get("MaxStamina") or 0)
                break
    return current, max_stamina


def _post_json(session: StorySession, path: str, body: bytes = b"") -> list[Any]:
    return session.post_bytes(path, body)


def claim_daily_freebies(session: StorySession) -> dict[str, Any]:
    """Theater stamina, login bonus, and free market frames (daily)."""
    out: dict[str, Any] = {}
    try:
        r = _post_json(session, "/api/Circles/ReceiveTheaterStamina")
        ok = bool(r[1][0]) if len(r) > 1 and r[1] else False
        out["theater_stamina"] = ok
    except ApiError as ex:
        out["theater_stamina"] = f"err:{ex.status}"
    try:
        r = _post_json(session, "/api/Home/CheckReceiveLoginBonus")
        out["login_bonus"] = str(r[1] if len(r) > 1 else r)[:200]
    except ApiError as ex:
        out["login_bonus"] = f"err:{ex.status}"

    # market: buy any frame whose master requires 0 currency (free)
    try:
        r = _post_json(session, "/api/Shops/GetOrRefreshMarket")
        things = r[1].get("things") if len(r) > 1 and isinstance(r[1], dict) else []
        free_numbers = [
            t.get("frameNumber")
            for t in things
            if isinstance(t, dict)
            and t.get("hasPurchased") is False
            and t.get("frameNumber") is not None
        ]
        # cross-check against the master: only claim frames with 0 cost
        base = Path("masterdata/tables")
        mf = base / "MarketFrameThingMaster.json"
        if mf.exists():
            master = {
                r["Id"]: r
                for r in json.loads(mf.read_text(encoding="utf-8"))
            }
            free_numbers = [
                t.get("frameNumber")
                for t in things
                if isinstance(t, dict)
                and t.get("hasPurchased") is False
                and (master.get(t.get("marketFrameThingMasterId")) or {}).get(
                    "RequiredThingQuantity"
                )
                in (0, None)
            ]
        claimed: list[int] = []
        if free_numbers:
            resp = _post_json(
                session,
                "/api/Shops/ExchangeMarketThings",
                msgpack.packb(free_numbers, use_bin_type=True),
            )
            claimed = free_numbers
            out["market"] = str(resp[1] if len(resp) > 1 else resp)[:200]
        else:
            out["market"] = "none-free"
    except ApiError as ex:
        out["market"] = f"err:{ex.status}"
    return out


def claim_daily_missions(session: StorySession) -> list[Any]:
    """Receive all Daily (category 4) mission rewards."""
    try:
        r = _post_json(
            session, "/api/Missions/receiveRewards?missionCategory=4"
        )
        return r[1] if len(r) > 1 else r
    except ApiError as ex:
        return [f"err:{ex.status}"]


def unlock_pending_stories(
    session: StorySession,
    *,
    masterdata_dir: str | os.PathLike[str] = "masterdata/tables",
    attempted: set[int] | None = None,
    include_spots: bool = False,
    max_candidates: int = 20,
    mode: str = "both",
) -> list[tuple[int, str, str]]:
    """Scan story tables and unlock/read episodes whose prereq is satisfied.

    Lightweight: only episodes that are not yet completed are considered;
    character episodes require the character to be owned, main/event episodes
    require their PreEpisodeMasterId to be in the completed set.
    """
    attempted = attempted if attempted is not None else set()
    state = fetch_user_state(session)
    episodes = load_episodes(masterdata_dir)
    # non-spot candidates first so limited batches clear character/special
    # stories before the large spot backlog.
    episodes.sort(key=lambda e: e.kind == "spot")
    completed = {eid for eid, done in state.readmarks.items() if done}
    owned = state.owned_characters
    outcomes: list[tuple[int, str, str]] = []

    def try_episode(ep) -> str:
        if ep.character_id is not None:
            if ep.character_id not in owned:
                return "skip:not-owned"
            if ep.character_order:
                release_side_story(session, ep.character_id, ep.character_order)
        details = get_episode_details(session, ep.episode_id)
        if not details:
            return "skip:locked"
        if mode in ("read", "both"):
            read_episode(session, ep.episode_id, "read")
        if mode in ("readall", "both"):
            read_episode(session, ep.episode_id, "readall")
        return "ok"

    processed = 0
    for ep in episodes:
        if processed >= max_candidates:
            break
        if ep.kind == "spot" and not include_spots:
            continue
        if ep.episode_id in completed or state.readmarks.get(ep.episode_id, False):
            continue
        if ep.episode_id in attempted:
            # a previous Read-only pass left HasReadAll=false (red dot);
            # re-process it when this pass also ReadAlls.
            if mode != "both" or state.readmarks.get(ep.episode_id, False):
                continue
        if (
            ep.character_id is not None
            and ep.required_level
            and state.character_levels.get(ep.character_id, 0) < ep.required_level
        ):
            continue
        if ep.prerequisite and ep.prerequisite not in completed:
            continue
        processed += 1
        try:
            status = try_episode(ep)
        except ApiError as ex:
            status = f"err:{ex.status}"
        except Exception as ex:  # noqa: BLE001
            status = f"err:{type(ex).__name__}:{ex}"
        if not status.startswith("err"):
            attempted.add(ep.episode_id)
        if status not in ("skip:locked", "skip:not-owned"):
            outcomes.append((ep.episode_id, ep.kind, status))
    return outcomes


def scan_stories_at_login(
    session: StorySession,
    *,
    masterdata_dir: str | os.PathLike[str] = "masterdata/tables",
    state_file: str | os.PathLike[str] = STATE_FILE,
    max_candidates: int = 30,
) -> list[tuple[int, str, str]]:
    """After login, scan scene (spot) + other stories and clear red dots.

    Uses Read + ReadAll so HasReadAll becomes true (the in-game red dot /
    diamond balloon is driven by HasReadAll=false; plain Read would leave it).
    """
    state: dict[str, Any] = {}
    if Path(state_file).exists():
        try:
            state = json.loads(Path(state_file).read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            state = {}
    attempted: set[int] = set(state.get("story_attempted", []))
    outcomes = unlock_pending_stories(
        session,
        masterdata_dir=masterdata_dir,
        attempted=attempted,
        include_spots=True,
        max_candidates=max_candidates,
        mode="both",
    )
    state["story_attempted"] = sorted(attempted)
    Path(state_file).write_text(
        json.dumps(state, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    return outcomes


def play_lives_with_stamina(
    session: StorySession,
    plans: list[LivePlan],
    *,
    party_id: int,
    ratio: int = 10,
    wait_margin: int = 30,
    notations_dir: str | os.PathLike[str] = "notations",
    real_chart: bool = False,
    max_plays: int | None = None,
    on_song_done=None,
) -> tuple[int, int]:
    """Play lives with `ratio`x stamina until stamina is insufficient."""
    music_cost: dict[int, int] = {}
    base = Path("masterdata/tables")
    mm = base / "MusicMaster.json"
    if mm.exists():
        for r in json.loads(mm.read_text(encoding="utf-8")):
            music_cost[r["Id"]] = int(r.get("StaminaConsumption") or 0)

    played = 0
    played_ok = 0
    for plan in plans:
        if max_plays and played >= max_plays:
            break
        cost = music_cost.get(plan.music_id, 25) * ratio
        current, _max = fetch_stamina(session)
        if current < cost:
            print(f"[*] stamina {current} < {cost}, stop")
            break
        print(
            f"[{plan.music_id:>5}/{plan.difficulty}] 10x {plan.music_name[:24]} "
            f"stamina {current}->{current - cost}"
        )
        result = play_one(
            session,
            plan,
            party_id,
            wait_margin=wait_margin,
            real_chart=real_chart,
            notations_dir=notations_dir,
            use_stamina=True,
            stamina_ratio=ratio,
        )
        played += 1
        if result.status == "ok":
            played_ok += 1
        print(f"    -> {result.detail}")
        if on_song_done:
            on_song_done()
    return played, played_ok


def run_daily(
    session: StorySession,
    plans: list[LivePlan],
    *,
    party_id: int | None = None,
    ratio: int = 10,
    wait_margin: int = 30,
    notations_dir: str | os.PathLike[str] = "notations",
    real_chart: bool = False,
    wait_day: bool = False,
    max_plays: int | None = None,
    state_file: str | os.PathLike[str] = STATE_FILE,
) -> dict[str, Any]:
    """Run one daily cycle (or loop across day boundaries with --wait-day)."""
    from .lives import current_party_id

    if party_id is None:
        party_id = current_party_id(session)
    if not party_id:
        raise RuntimeError("cannot determine current party id")

    state: dict[str, Any] = {}
    if Path(state_file).exists():
        try:
            state = json.loads(Path(state_file).read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            state = {}

    attempted: set[int] = set(state.get("story_attempted", []))
    summary: dict[str, Any] = {}
    while True:
        today = game_day_id()
        new_day = state.get("last_day") != today
        if new_day:
            print(f"[*] new game day {today}: refreshing session")
            session.refresh()
            state["last_day"] = today
            Path(state_file).write_text(
                json.dumps(state, ensure_ascii=False, indent=2),
                encoding="utf-8",
            )

        freebies = claim_daily_freebies(session)
        print("[*] daily freebies:", json.dumps(freebies, ensure_ascii=False))

        scanned = scan_stories_at_login(session, state_file=state_file)
        print(f"[*] login story scan: {len(scanned)} processed")
        for eid, kind, status in scanned[:10]:
            print(f"    {eid} [{kind}] {status}")

        # lessons (稽古) refresh daily; consume until server says exhausted
        from .lesson import run_lessons

        lesson_results = run_lessons(
            session,
            wait_margin=wait_margin,
            notations_dir=notations_dir,
        )
        print(f"[*] lessons ok={sum(1 for r in lesson_results if r.status == 'ok')}")

        played, played_ok = play_lives_with_stamina(
            session,
            plans,
            party_id=party_id,
            ratio=ratio,
            wait_margin=wait_margin,
            notations_dir=notations_dir,
            real_chart=real_chart,
            max_plays=max_plays,
            on_song_done=lambda: unlock_pending_stories(
                session, attempted=attempted, mode="both"
            ),
        )
        print(f"[*] 10x lives played={played} ok={played_ok}")

        unlocked = unlock_pending_stories(
            session, attempted=attempted, mode="both"
        )
        print(f"[*] story unlock scan: {len(unlocked)} processed")
        for eid, kind, status in unlocked[:10]:
            print(f"    {eid} [{kind}] {status}")

        rewards = claim_daily_missions(session)
        print(f"[*] daily missions claimed: {len(rewards)}")

        state["story_attempted"] = sorted(attempted)
        Path(state_file).write_text(
            json.dumps(state, ensure_ascii=False, indent=2),
            encoding="utf-8",
        )

        summary = {
            "day": today,
            "freebies": freebies,
            "lessons_ok": sum(1 for r in lesson_results if r.status == "ok"),
            "lives_played": played,
            "lives_ok": played_ok,
            "stories_processed": len(unlocked),
            "mission_rewards": len(rewards),
        }
        if not wait_day:
            break
        boundary = next_day_boundary()
        wait = (boundary - datetime.now(CST)).total_seconds()
        print(f"[*] waiting {int(wait // 3600)}h {int(wait % 3600 // 60)}m "
              f"until {boundary.isoformat()}")
        time.sleep(max(60, wait))
    return summary
