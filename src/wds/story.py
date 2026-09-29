"""Bulk story reading: main story, event stories, character side stories.

Per-episode read mark (IDataObject tag 95): [95, [episodeMasterId, completed]]
with completed=False (opened via Read) or True (finished via ReadAll).

Rewards (see docs/protocol.md §7): main stories grant 歌劇目録 x1 on ReadAll
even when already read; event/character stories grant their package once on
the first finishing call (Read or ReadAll); repeat calls are idempotent.
Character episodes additionally need ReleaseSideStory?order=1|2 first, or the
server answers HTTP 400 VAL003 mEpisode.

Scene text extraction (story_texts.py) decodes the CDN .bin
(gzip -> msgpack stream -> ext-98 LZ4) and reads row[7] as the dialogue.
"""

from __future__ import annotations

import concurrent.futures as _futures
import json
import os
import threading
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Callable, Iterable

from . import codec
from .api import ApiClient, ApiError
from .login import LoginService
from .story_texts import (
    TextCollector,
    company_label,
    download_scene,
    find_scene_file,
)
from .token_store import TokenStore


EPISODE_KINDS = ("main", "event", "character", "spot", "special")


@dataclass(frozen=True)
class StoryEpisode:
    episode_id: int
    kind: str
    title: str
    story_master_id: int | None = None
    company_id: int | None = None
    order: int = 0
    prerequisite: int | None = None
    character_id: int | None = None
    character_order: int | None = None
    required_level: int | None = None

    @property
    def group_key(self) -> tuple[int, int]:
        return (self.story_master_id or self.episode_id, self.order)


@dataclass
class UserReadState:
    readmarks: dict[int, bool] = field(default_factory=dict)
    owned_characters: set[int] = field(default_factory=set)
    character_levels: dict[int, int] = field(default_factory=dict)


@dataclass
class EpisodeOutcome:
    episode_id: int
    kind: str
    status: str  # ok | locked | prereq | error | skipped
    detail: str = ""
    rewards: list[dict[str, Any]] = field(default_factory=list)
    scene: str | None = None
    text_lines: int = 0


@dataclass
class StoryRunResult:
    outcomes: list[EpisodeOutcome] = field(default_factory=list)
    released: list[int] = field(default_factory=list)
    refreshed: int = 0

    def count(self, status: str) -> int:
        return sum(1 for o in self.outcomes if o.status == status)


class StorySession:
    """ApiClient wrapper with automatic 引继 (take-over) token refresh.

    On HTTP 401/403 the current Bearer is treated as stale and the session
    re-issues it: first through Authenticate with the stored login token,
    then (if that fails) through the reusable 引继 code, which always yields
    a fresh login token + Bearer pair.
    """

    def __init__(
        self,
        api: ApiClient,
        credentials: str | os.PathLike[str] = "credentials.json",
        linkage_code: str | None = None,
        password: str | None = None,
        *,
        authenticate_compressed: bool = False,
    ):
        self.api = api
        self.store = TokenStore(credentials)
        self.login = LoginService(
            api, self.store, authenticate_compressed=authenticate_compressed
        )
        self.linkage_code = linkage_code
        self.password = password
        self._token: str | None = None
        self._lock = threading.Lock()
        self.refreshed = 0

    # ------------------------------------------------------------- tokens

    def token(self) -> str:
        with self._lock:
            if self._token and self._token_exp_ok():
                return self._token
            self._token = self._issue_token()
            return self._token

    def _token_exp_ok(self) -> bool:
        if not self._token:
            return False
        from .token_store import parse_jwt_exp

        exp = parse_jwt_exp(self._token)
        return exp is None or exp - 300 > int(time.time())

    def _issue_token(self) -> str:
        creds = self.store.load()
        if creds.has_login_token():
            try:
                auth = self.api.authenticate(creds.login_token)
                self.store.save_api_token(auth.token)
                return auth.token
            except ApiError:
                pass
        if not self.linkage_code or not self.password:
            raise RuntimeError(
                "no usable stored token; pass --linkage-code/--password "
                "to re-引继"
            )
        result = self.login.takeover(self.linkage_code, self.password)
        auth = self.api.authenticate(result.login_token or "")
        self.store.save_api_token(auth.token)
        return auth.token

    def refresh(self) -> str:
        with self._lock:
            self._token = None
            self._token = self._issue_token()
            self.refreshed += 1
            return self._token

    # ------------------------------------------------------------- network

    def post(self, path: str) -> list[Any]:
        return self._call("POST", path, 0)

    def get(self, path: str) -> list[Any]:
        return self._call("GET", path, 0)

    def post_bytes(self, path: str, body: bytes) -> list[Any]:
        """POST with an explicit raw body (used by the lives play flow)."""
        return self._call("POST", path, 0, body=body)

    def _call(
        self,
        method: str,
        path: str,
        attempt: int,
        body: bytes | None = None,
    ) -> list[Any]:
        try:
            return self.api._request(
                method, path,
                body if body is not None else (b"" if method == "POST" else None),
                token=self.token(),
            )
        except ApiError as ex:
            if ex.status in (401, 403) and attempt < 2:
                self.refresh()
                return self._call(method, path, attempt + 1, body=body)
            raise


# ------------------------------------------------------------ episode list


def load_episodes(
    masterdata_dir: str | os.PathLike[str] = "masterdata/tables",
) -> list[StoryEpisode]:
    """Build the episode catalogue from the master-data JSON tables."""
    base = Path(masterdata_dir)
    stories = _read_rows(base / "StoryMaster.json")
    by_id = {r["Id"]: r for r in stories}

    episodes: list[StoryEpisode] = []
    for row in _read_rows(base / "EpisodeMaster.json"):
        sm = by_id.get(row["StoryMasterId"], {})
        episodes.append(
            StoryEpisode(
                episode_id=row["Id"],
                kind="main",
                title=row.get("Title") or "",
                story_master_id=row["StoryMasterId"],
                company_id=sm.get("CompanyMasterId"),
                order=row.get("Order") or 0,
                prerequisite=row.get("PreEpisodeMasterId"),
            )
        )
    for row in _read_rows(base / "StoryEventEpisodeMaster.json"):
        sm = by_id.get(row["StoryMasterId"], {})
        episodes.append(
            StoryEpisode(
                episode_id=row["Id"],
                kind="event",
                title=row.get("Title") or "",
                story_master_id=row["StoryMasterId"],
                company_id=sm.get("CompanyMasterId"),
                order=row.get("Order") or 0,
                prerequisite=row.get("RequiredReadEpisodeMasterId"),
            )
        )
    for row in _read_rows(base / "CharacterEpisodeMaster.json"):
        episodes.append(
            StoryEpisode(
                episode_id=row["EpisodeMasterId"],
                kind="character",
                title="",
                story_master_id=None,
                company_id=None,
                order=row.get("EpisodeOrder") or 0,
                prerequisite=None,
                character_id=row.get("CharacterMasterId"),
                character_order=row.get("EpisodeOrder"),
                required_level=row.get("RequiredCharacterLevel"),
            )
        )
    for row in _read_rows(base / "SpotConversationMaster.json"):
        episodes.append(
            StoryEpisode(
                episode_id=row["EpisodeMasterId"],
                kind="spot",
                title=row.get("Title") or "",
                order=row.get("Order") or 0,
            )
        )
    for row in _read_rows(base / "SpecialEpisodeMaster.json"):
        episodes.append(
            StoryEpisode(
                episode_id=row["Id"],
                kind="special",
                title=row.get("Title") or "",
                order=row.get("Order") or 0,
            )
        )
    return episodes


def _read_rows(path: Path) -> list[dict[str, Any]]:
    if not path.exists():
        return []
    return json.loads(path.read_text(encoding="utf-8"))


# ------------------------------------------------------------ user state


def fetch_user_state(session: StorySession) -> UserReadState:
    """Parse /api/data/user IDataObjects into read marks + owned characters."""
    payloads = session.get("/api/data/user")
    state = UserReadState()
    objects = payloads[1] if len(payloads) > 1 and isinstance(payloads[1], list) else []
    for obj in objects:
        if not isinstance(obj, list) or len(obj) < 2:
            continue
        tag, data = obj[0], obj[1]
        if tag == 95 and isinstance(data, list) and len(data) == 2:
            state.readmarks[data[0]] = bool(data[1])
        elif tag == 4 and isinstance(data, list) and len(data) > 1:
            if isinstance(data[1], int) and 100000 < data[1] < 200000:
                state.owned_characters.add(data[1])
                if len(data) > 2 and isinstance(data[2], int):
                    state.character_levels[data[1]] = data[2]
    return state


# ---------------------------------------------------------------- helpers


# ------------------------------------------------------------ api actions


def get_episode_details(session: StorySession, episode_id: int) -> list[Any] | None:
    """Return the GetDetails payload object, or None when locked."""
    try:
        payloads = session.post(
            f"/api/Episodes/{episode_id}/GetDetails?episodeMasterId={episode_id}"
        )
    except ApiError as ex:
        if ex.status in (400, 403):
            return None
        raise
    for obj in payloads:
        if isinstance(obj, list) and len(obj) == 4 and isinstance(obj[3], str):
            return obj
    return None


def read_episode(
    session: StorySession,
    episode_id: int,
    mode: str,
) -> list[dict[str, Any]]:
    """POST Read / ReadAll and return the ReceivedThing reward array."""
    fields = ["Type", "Id", "Quantity", "OriginalType", "OriginalId",
              "AfterPhase", "SentInbox"]
    action = {"read": "Read", "readall": "ReadAll"}[mode]
    payloads = session.post(
        f"/api/Episodes/{episode_id}/{action}?episodeMasterId={episode_id}"
    )
    rewards: list[dict[str, Any]] = []
    if len(payloads) > 1 and isinstance(payloads[1], list):
        for thing in payloads[1]:
            if isinstance(thing, list) and len(thing) <= len(fields):
                rewards.append(
                    {
                        name: codec.to_json_value(value)
                        for name, value in zip(fields, thing)
                    }
                )
    return rewards


def release_side_story(
    session: StorySession, character_id: int, order: int
) -> bool:
    try:
        payloads = session.post(
            f"/api/Characters/{character_id}/ReleaseSideStory"
            f"?characterMasterId={character_id}&order={order}"
        )
    except ApiError as ex:
        if ex.status in (400, 403):
            return False
        raise
    return (
        len(payloads) > 1
        and isinstance(payloads[1], list)
        and bool(payloads[1])
        and payloads[1][0] is True
    )


# ---------------------------------------------------------------- runner


def run_story_reader(
    session: StorySession,
    episodes: Iterable[StoryEpisode],
    *,
    state: UserReadState | None = None,
    modes: tuple[str, ...] = ("readall",),
    kinds: tuple[str, ...] = EPISODE_KINDS,
    owned_only: bool = False,
    unread_only: bool = True,
    release_side_stories: bool = True,
    collect_texts: bool = True,
    masterdata_dir: str | os.PathLike[str] = "masterdata/tables",
    scenes_dir: str | os.PathLike[str] = "scenes",
    texts_dir: str | os.PathLike[str] = "story_texts",
    concurrency: int = 4,
    delay: float = 0.4,
    force_scene: bool = False,
    progress: Callable[[int, int], None] | None = None,
) -> StoryRunResult:
    """Process every selected episode: unlock, fetch, read, collect text."""
    api = session.api
    env = api.fetch_environment()
    base = env.master_data_url.rstrip("/")
    result = StoryRunResult()
    if state is None:
        state = fetch_user_state(session)

    selected = [
        ep
        for ep in episodes
        if ep.kind in kinds
        and (
            not owned_only
            or ep.kind != "character"
            or ep.character_id in state.owned_characters
        )
        and (not unread_only or not state.readmarks.get(ep.episode_id))
    ]
    # episode ids overlap between EpisodeMaster (main) and
    # StoryEventEpisodeMaster (event) for the 4 event chapters + collab;
    # keep the main entry so each episode is only processed once.
    selected = _dedupe_episodes(selected)

    collector = TextCollector(texts_dir) if collect_texts else None
    Path(scenes_dir).mkdir(parents=True, exist_ok=True)

    lock = threading.Lock()
    released: set[tuple[int, int]] = set()
    done = 0
    started = time.time()

    def handle_one(ep: StoryEpisode) -> EpisodeOutcome:
        try:
            # 1) character side stories: release the matching story first
            if (
                ep.kind == "character"
                and release_side_stories
                and ep.character_id
                and ep.character_order
            ):
                key = (ep.character_id, ep.character_order)
                with lock:
                    if key not in released:
                        ok = release_side_story(
                            session, ep.character_id, ep.character_order
                        )
                        if ok:
                            released.add(key)
                            result.released.append(ep.character_id)

            # 2) scene asset (GetDetails) + local bin
            scene_path = find_scene_file(scenes_dir, ep.episode_id)
            title = ep.title
            details = get_episode_details(session, ep.episode_id)
            if details is None:
                return EpisodeOutcome(
                    ep.episode_id, ep.kind, "locked", detail="EPI001"
                )
            title = details[0] if isinstance(details[0], str) else title
            if scene_path is None or force_scene:
                asset = details[3]
                url = f"{base}/{asset}"
                name = asset.split("?")[0].rsplit("/", 1)[-1]
                dest = Path(scenes_dir) / name
                if not dest.exists() or force_scene:
                    download_scene(url, dest)
                scene_path = dest

            # 3) read / read-all
            rewards: list[dict[str, Any]] = []
            for mode in modes:
                try:
                    rewards.extend(read_episode(session, ep.episode_id, mode))
                except ApiError as ex:
                    if ex.status in (400, 403):
                        return EpisodeOutcome(
                            ep.episode_id, ep.kind, "locked", detail="VAL003"
                        )
                    raise
                if delay:
                    time.sleep(delay)

            # 4) collect dialogue text
            text_lines = 0
            if collector is not None and scene_path is not None:
                text_lines = collector.add(
                    ep.episode_id,
                    kind=ep.kind,
                    title=title,
                    company_id=ep.company_id,
                    scene_path=scene_path,
                )

            with lock:
                state.readmarks[ep.episode_id] = True
            return EpisodeOutcome(
                episode_id=ep.episode_id,
                kind=ep.kind,
                status="ok",
                detail=title,
                rewards=rewards,
                scene=scene_path.name if scene_path else None,
                text_lines=text_lines,
            )
        except Exception as ex:  # noqa: BLE001
            return EpisodeOutcome(
                ep.episode_id, ep.kind, "error", detail=f"{type(ex).__name__}: {ex}"
            )

    groups: dict[tuple[str, int], list[StoryEpisode]] = {}
    for ep in selected:
        key = (
            (ep.kind, ep.story_master_id or 0)
            if ep.kind in ("main", "event")
            else (ep.kind, ep.character_id or ep.episode_id)
        )
        groups.setdefault(key, []).append(ep)
    for group in groups.values():
        group.sort(key=lambda ep: ep.group_key)

    def run_group(eps: list[StoryEpisode]) -> list[EpisodeOutcome]:
        return [handle_one(ep) for ep in eps]

    total = len(selected)
    outcomes_by_id: dict[int, EpisodeOutcome] = {}
    with _futures.ThreadPoolExecutor(max_workers=max(1, concurrency)) as pool:
        futures = [pool.submit(run_group, g) for g in groups.values()]
        for future in _futures.as_completed(futures):
            outcomes = future.result()
            with lock:
                for outcome in outcomes:
                    outcomes_by_id[outcome.episode_id] = outcome
                done += len(outcomes)
                if progress:
                    progress(done, total)

    # second pass: retry locked (prerequisite races) and transient errors
    bad = [eid for eid, o in outcomes_by_id.items()
           if o.status in ("locked", "error")]
    retry_eps = [ep for ep in selected if ep.episode_id in set(bad)]
    retry_eps.sort(key=lambda ep: ep.group_key)
    if retry_eps:
        print(f"[*] retrying {len(retry_eps)} episodes")
        for ep in retry_eps:
            time.sleep(delay)
            outcome = handle_one(ep)
            with lock:
                outcomes_by_id[outcome.episode_id] = outcome
                if progress:
                    progress(done, total)

    result.refreshed = session.refreshed
    result.outcomes = list(outcomes_by_id.values())
    if collector is not None:
        collector.save_index(time.time() - started)
    return result


def _dedupe_episodes(
    episodes: list[StoryEpisode],
) -> list[StoryEpisode]:
    """Prefer the main entry when the same episode id appears in two tables."""
    priority = {"main": 0, "event": 1, "character": 2, "spot": 3, "special": 4}
    best: dict[int, StoryEpisode] = {}
    for ep in episodes:
        prev = best.get(ep.episode_id)
        if prev is None or priority[ep.kind] < priority[prev.kind]:
            best[ep.episode_id] = ep
    return list(best.values())


def summarize(result: StoryRunResult) -> str:
    by_kind: dict[str, dict[str, int]] = {}
    for o in result.outcomes:
        k = by_kind.setdefault(o.kind, {})
        k[o.status] = k.get(o.status, 0) + 1
        if o.rewards:
            for r in o.rewards:
                key = f"reward:{r.get('Id')}x{r.get('Quantity')}"
                k[key] = k.get(key, 0) + 1
    return json.dumps(by_kind, ensure_ascii=False, indent=2)


# ------------------------------------------------------------ local report


def build_status_report(
    episodes: Iterable[StoryEpisode],
    state: UserReadState,
    texts_index: dict[str, Any] | None = None,
) -> list[dict[str, Any]]:
    """Local report of every episode: completion, unlock and text counts."""
    texts = texts_index or {}
    rows: list[dict[str, Any]] = []
    for ep in episodes:
        if ep.kind not in EPISODE_KINDS:
            continue
        completed = state.readmarks.get(ep.episode_id, False)
        if ep.kind == "character" and ep.character_id not in state.owned_characters:
            status = "not-owned"
        elif completed:
            status = "completed"
        elif ep.kind == "character" and ep.required_level and (
            state.character_levels.get(ep.character_id or -1, 0)
            < ep.required_level
        ):
            status = "locked-level"
        else:
            status = "unread"
        meta = texts.get(str(ep.episode_id), {})
        rows.append(
            {
                "episode_id": ep.episode_id,
                "kind": ep.kind,
                "title": meta.get("title") or ep.title,
                "company": meta.get("company") or company_label(ep.company_id),
                "status": status,
                "scene": meta.get("scene"),
                "text_lines": meta.get("lines", 0),
                "character_id": ep.character_id,
                "character_order": ep.character_order,
            }
        )
    rows.sort(key=lambda r: (r["kind"], r["episode_id"]))
    return rows
