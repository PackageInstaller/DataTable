"""Command line entry points: python -m wds <command>."""

from __future__ import annotations

import argparse
import json
import os
import sys
from pathlib import Path

from . import __version__
from .api import ApiClient, ApiError, extract_token_from_har
from .login import LoginService, NeedsTakeOver, TakeOverFailed
from .token_store import TokenStore


def _credential_args(p: argparse.ArgumentParser) -> None:
    p.add_argument("--credentials", default="credentials.json",
                   help="dynamic token store file")
    p.add_argument("--linkage-code",
                   default=os.environ.get("WDS_LINKAGE_CODE"),
                   help="引继 ID, or env WDS_LINKAGE_CODE (needed when no "
                        "usable token is stored)")
    p.add_argument("--password",
                   default=os.environ.get("WDS_PASSWORD"),
                   help="引继 password, or env WDS_PASSWORD")


def _token_args(p: argparse.ArgumentParser) -> None:
    p.add_argument("--token", default=None, help="Bearer token (else read from store/har)")
    p.add_argument("--har", default="wds_2026_08_02_18_43_12.har",
                   help="HAR to extract a Bearer token from when --token is absent")
    p.add_argument("--credentials", default="credentials.json",
                   help="dynamic token store file")


def cmd_fetch_env(args: argparse.Namespace) -> int:
    api = ApiClient(args.api_base, timeout=args.timeout)
    env = api.fetch_environment()
    print(json.dumps(env.__dict__, ensure_ascii=False, indent=2))
    return 0


def cmd_login(args: argparse.Namespace) -> int:
    api = ApiClient(args.api_base, timeout=args.timeout)
    store = TokenStore(args.credentials)
    service = LoginService(
        api,
        store,
        apk_hash=args.apk_hash,
        apk_application_signature=args.apk_application_signature,
        app_version=args.app_version,
        authenticate_compressed=args.compress_auth,
    )
    try:
        session = service.login(args.linkage_code, args.password)
    except NeedsTakeOver as ex:
        print(f"[-] {ex}", file=sys.stderr)
        return 2
    except TakeOverFailed as ex:
        print(f"[-] {ex}", file=sys.stderr)
        return 3
    except ApiError as ex:
        print(f"[-] api error: {ex}", file=sys.stderr)
        return 4
    creds = session.credentials
    print(json.dumps(
        {
            "user_id": creds.user_id,
            "user_name": creds.user_name,
            "rank": creds.rank,
            "login_token": creds.login_token,
            "api_token": creds.api_token,
            "api_token_exp": creds.api_token_exp,
            "takeover": session.takeover.is_success if session.takeover else None,
        },
        ensure_ascii=False,
        indent=2,
    ))
    return 0


def cmd_master_data(args: argparse.Namespace) -> int:
    from .master_data import update_master_data

    api = ApiClient(args.api_base, timeout=args.timeout)
    token = (
        args.token
        or TokenStore(args.credentials).load().api_token
        or extract_token_from_har(args.har)
    )
    if not token:
        print("[-] no token: pass --token, --har or login first", file=sys.stderr)
        return 2
    summary = update_master_data(
        api,
        token,
        out_dir=args.out_dir,
        db_path=args.db,
        force=args.force,
        indent=args.indent,
    )
    n_tables = len(summary["tables"])
    n_rows = sum(t["records"] for t in summary["tables"].values())
    print(f"[*] done: {n_tables} tables, {n_rows} records -> {args.out_dir}")
    return 0


def cmd_decode_har(args: argparse.Namespace) -> int:
    from .har_decode import decode_har

    out = decode_har(args.har, args.il2cpp_cs, args.il2cpp_json)
    with open(args.output, "w", encoding="utf-8") as f:
        json.dump(out, f, ensure_ascii=False, indent=2)
    print(f"[*] wrote {args.output} ({out['count']} endpoints)")
    for ep in out["apis"]:
        nf = len(ep["fields"]) if ep["fields"] else 0
        print(f"    {ep['api']:52s} {str(ep['method']):40s} {nf}")
    return 0


def cmd_fetch_scenes(args: argparse.Namespace) -> int:
    from .scenes import ensure_token, fetch_scenes
    from .login import NeedsTakeOver

    token = (
        args.token
        or TokenStore(args.credentials).load().api_token
        or extract_token_from_har(args.har)
    )
    if not token:
        try:
            token = ensure_token(args.credentials, args.linkage_code, args.password)
        except NeedsTakeOver as ex:
            print(f"[-] {ex}", file=sys.stderr)
            return 2
    api = ApiClient(args.api_base, timeout=args.timeout)
    ids = None
    if args.ids:
        ids = [int(x) for x in args.ids.split(",") if x.strip()]
    result = fetch_scenes(
        api,
        token,
        episode_ids=ids,
        masterdata_dir=args.masterdata,
        out_dir=args.out_dir,
        concurrency=args.concurrency,
        limit=args.limit,
        force=args.force,
    )
    print(
        f"[*] done: fetched={len(result.fetched)} "
        f"exists={len(result.existing)} locked={len(result.locked)} "
        f"errors={len(result.errors)}"
    )
    if result.errors:
        print("    errors:", result.errors[:10])
    return 0


def cmd_story_read(args: argparse.Namespace) -> int:
    from .story import (
        EPISODE_KINDS,
        StorySession,
        fetch_user_state,
        load_episodes,
        run_story_reader,
        summarize,
    )

    api = ApiClient(args.api_base, timeout=args.timeout)
    session = StorySession(
        api,
        args.credentials,
        linkage_code=args.linkage_code,
        password=args.password,
    )
    try:
        token = session.token()
    except Exception as ex:  # noqa: BLE001
        print(f"[-] cannot obtain token: {ex}", file=sys.stderr)
        return 4

    episodes = load_episodes(args.masterdata)
    if args.ids:
        wanted = {int(x) for x in args.ids.split(",") if x.strip()}
        episodes = [ep for ep in episodes if ep.episode_id in wanted]

    kinds = tuple(k.strip() for k in args.kinds.split(",") if k.strip())
    if "all" in kinds:
        kinds = EPISODE_KINDS
    state = fetch_user_state(session)
    print(
        f"[*] episodes={len(episodes)} kinds={kinds or 'all'} "
        f"owned={len(state.owned_characters)} "
        f"read-completed={sum(1 for v in state.readmarks.values() if v)}"
    )

    modes: tuple[str, ...]
    if args.mode == "both":
        modes = ("read", "readall")
    else:
        modes = (args.mode,)

    def progress(done: int, total: int) -> None:
        if done % 50 == 0 or done == total:
            print(f"[*] {done}/{total}")

    result = run_story_reader(
        session,
        episodes,
        state=state,
        modes=modes,
        kinds=kinds,
        owned_only=args.owned_only,
        unread_only=not args.all,
        release_side_stories=not args.no_release,
        collect_texts=not args.no_texts,
        masterdata_dir=args.masterdata,
        scenes_dir=args.scenes_dir,
        texts_dir=args.texts_dir,
        concurrency=args.concurrency,
        delay=args.delay,
        force_scene=args.force_scene,
        progress=progress,
    )
    if args.report:
        payload = [
            {
                "episode_id": o.episode_id,
                "kind": o.kind,
                "status": o.status,
                "detail": o.detail,
                "rewards": o.rewards,
                "scene": o.scene,
                "text_lines": o.text_lines,
            }
            for o in result.outcomes
        ]
        with open(args.report, "w", encoding="utf-8") as f:
            json.dump(payload, f, ensure_ascii=False, indent=2)
    print(
        f"[*] done: ok={result.count('ok')} locked={result.count('locked')} "
        f"errors={result.count('error')} refreshed={result.refreshed}"
    )
    print(summarize(result))
    return 0


def cmd_story_status(args: argparse.Namespace) -> int:
    from .story import (
        StorySession,
        build_status_report,
        fetch_user_state,
        load_episodes,
    )

    api = ApiClient(args.api_base, timeout=args.timeout)
    session = StorySession(api, args.credentials)
    try:
        state = fetch_user_state(session)
    except Exception as ex:  # noqa: BLE001
        print(f"[-] cannot fetch user state: {ex}", file=sys.stderr)
        return 4
    texts_index: dict = {}
    idx = Path(args.texts_dir) / "index.json"
    if idx.exists():
        texts_index = json.loads(idx.read_text(encoding="utf-8")).get("episodes", {})
    rows = build_status_report(load_episodes(args.masterdata), state, texts_index)
    if args.report:
        with open(args.report, "w", encoding="utf-8") as f:
            json.dump(rows, f, ensure_ascii=False, indent=2)
    summary: dict[str, dict[str, int]] = {}
    for r in rows:
        k = summary.setdefault(r["kind"], {})
        k[r["status"]] = k.get(r["status"], 0) + 1
        if r["text_lines"]:
            k["with_text"] = k.get("with_text", 0) + 1
    print(json.dumps(summary, ensure_ascii=False, indent=2))
    print(f"[*] wrote {args.report}")
    return 0


def cmd_lives_play(args: argparse.Namespace) -> int:
    from .lives import load_lives, run_lives, summarize
    from .story import StorySession

    api = ApiClient(args.api_base, timeout=args.timeout)
    session = StorySession(
        api,
        args.credentials,
        linkage_code=args.linkage_code,
        password=args.password,
    )
    try:
        session.token()
    except Exception as ex:  # noqa: BLE001
        print(f"[-] cannot obtain token: {ex}", file=sys.stderr)
        return 4

    from .daily import scan_stories_at_login

    scanned = scan_stories_at_login(session)
    print(f"[*] login story scan: {len(scanned)} processed")

    plans = load_lives(args.masterdata)
    if args.music:
        wanted = {int(x) for x in args.music.split(",") if x.strip()}
        plans = [p for p in plans if p.music_id in wanted]
    if args.difficulty:
        plans = [p for p in plans if p.difficulty in args.difficulty]
    if args.limit:
        plans = plans[: args.limit]
    if args.offset:
        plans = plans[args.offset :]

    print(
        f"[*] lives={len(plans)} margin={args.margin}s "
        f"notes={args.notes} progress={args.progress}"
    )
    if args.dry_run:
        for p in plans:
            print(f"    {p.live_id} music={p.music_id} diff={p.difficulty} "
                  f"lvl={p.level} {p.duration_seconds}s {p.music_name}")
        return 0

    results = run_lives(
        session,
        plans,
        party_id=args.party,
        random_party=args.random_party,
        party_pool=args.party_pool,
        wait_margin=args.margin,
        note_count=args.notes,
        real_chart=args.real_chart,
        notations_dir=args.notations_dir,
        progress_file=args.progress,
        resume=not args.no_resume,
    )
    print(f"[*] done: {summarize(results)}")
    if args.daily:
        from .daily import run_daily

        summary = run_daily(
            session,
            plans,
            party_id=args.party,
            ratio=args.daily_ratio,
            wait_margin=args.margin,
            notations_dir=args.notations_dir,
            real_chart=args.real_chart,
            wait_day=args.wait_day,
            max_plays=args.daily_max_plays,
        )
        print("[*] daily:", json.dumps(summary, ensure_ascii=False))
    return 0


def cmd_daily(args: argparse.Namespace) -> int:
    from .daily import run_daily
    from .lives import load_lives
    from .story import StorySession

    api = ApiClient(args.api_base, timeout=args.timeout)
    session = StorySession(
        api,
        args.credentials,
        linkage_code=args.linkage_code,
        password=args.password,
    )
    try:
        session.token()
    except Exception as ex:  # noqa: BLE001
        print(f"[-] cannot obtain token: {ex}", file=sys.stderr)
        return 4
    plans = load_lives(args.masterdata)
    if args.music:
        wanted = {int(x) for x in args.music.split(",") if x.strip()}
        plans = [p for p in plans if p.music_id in wanted]
    summary = run_daily(
        session,
        plans,
        party_id=args.party,
        ratio=args.ratio,
        wait_margin=args.margin,
        notations_dir=args.notations_dir,
        real_chart=args.real_chart,
        wait_day=args.wait_day,
        max_plays=args.max_plays,
        state_file=args.state,
    )
    print("[*] daily:", json.dumps(summary, ensure_ascii=False))
    return 0


def cmd_assets_update(args: argparse.Namespace) -> int:
    from .assets import ASSET_TYPES, update_assets

    api = ApiClient(args.api_base, timeout=args.timeout)
    env = api.fetch_environment()
    types = tuple(t.strip() for t in args.types.split(",") if t.strip())
    summary = update_assets(
        env,
        out_dir=args.out_dir,
        concurrency=args.concurrency,
        force=args.force,
        types=types,
    )
    print(json.dumps(summary, ensure_ascii=False, indent=2))
    return 0


def cmd_notation_fetch(args: argparse.Namespace) -> int:
    from .notation import download_charts

    api = ApiClient(args.api_base, timeout=args.timeout)
    env = api.fetch_environment()
    music_ids = None
    if args.music:
        music_ids = [int(x) for x in args.music.split(",") if x.strip()]
    difficulties = None
    if args.difficulty:
        difficulties = [int(x) for x in args.difficulty.split(",") if x.strip()]
    summary = download_charts(
        env,
        out_dir=args.out_dir,
        music_ids=music_ids,
        difficulties=difficulties,
    )
    print(f"[*] charts: {sum(1 for v in summary.values() if 'notes' in v)}")
    return 0


def cmd_notation_index(args: argparse.Namespace) -> int:
    from .notation import build_notation_index

    if args.asset_url:
        asset_url = args.asset_url
    else:
        api = ApiClient(args.api_base, timeout=args.timeout)
        asset_url = api.fetch_environment().asset_url
    data = build_notation_index(
        asset_url,
        masterdata_dir=args.masterdata,
        notations_dir=args.notations_dir,
    )
    with open(args.output, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=args.indent)
    print(
        f"[*] wrote {args.output}: songs={data['song_count']} "
        f"charts={data['chart_count']}"
    )
    return 0


def cmd_static_assets(args: argparse.Namespace) -> int:
    from .static_assets import (
        backup_static_assets,
        collect_paths_from_masterdata,
        collect_paths_from_notification_contents,
        collect_paths_from_notifications,
    )
    from .story import StorySession

    api = ApiClient(args.api_base, timeout=args.timeout)
    paths: set[str] = set()
    paths.update(collect_paths_from_masterdata(args.masterdata))
    print(f"[*] master data paths: {len(paths)}")
    paths.update(collect_paths_from_notification_contents(args.api_base))
    print(f"[*] after anonymous notifications: {len(paths)} unique")
    if not args.no_api:
        session = StorySession(
            api,
            args.credentials,
            linkage_code=args.linkage_code,
            password=args.password,
        )
        try:
            session.token()
        except Exception as ex:  # noqa: BLE001
            print(f"[-] cannot obtain token (skip API banners): {ex}")
        else:
            paths.update(collect_paths_from_notifications(session))
            print(f"[*] after notifications: {len(paths)} unique")
    if not paths:
        print("[-] no static asset paths found", file=sys.stderr)
        return 2
    env = api.fetch_environment()
    summary = backup_static_assets(
        env.asset_url,
        sorted(paths),
        out_dir=args.output,
        concurrency=args.concurrency,
        force=args.force,
    )
    print(
        f"[*] done: fetched={summary['fetched']} "
        f"exists={summary['existing']} errors={summary['errors']}"
    )
    return 0


def cmd_lessons(args: argparse.Namespace) -> int:
    from .lesson import run_lessons
    from .story import StorySession

    api = ApiClient(args.api_base, timeout=args.timeout)
    session = StorySession(
        api, args.credentials,
        linkage_code=args.linkage_code, password=args.password,
    )
    try:
        session.token()
    except Exception as ex:  # noqa: BLE001
        print(f"[-] cannot obtain token: {ex}", file=sys.stderr)
        return 4
    results = run_lessons(
        session,
        live_master_id=args.live,
        wait_margin=args.margin,
        notations_dir=args.notations_dir,
        max_plays=args.max_plays,
    )
    print(f"[*] lessons played: {sum(1 for r in results if r.status == 'ok')}")
    return 0


def cmd_auditions(args: argparse.Namespace) -> int:
    from .audition import run_auditions
    from .story import StorySession

    api = ApiClient(args.api_base, timeout=args.timeout)
    session = StorySession(
        api, args.credentials,
        linkage_code=args.linkage_code, password=args.password,
    )
    try:
        session.token()
    except Exception as ex:  # noqa: BLE001
        print(f"[-] cannot obtain token: {ex}", file=sys.stderr)
        return 4
    audition_ids = None
    if args.ids:
        audition_ids = [int(x) for x in args.ids.split(",") if x.strip()]
    results = run_auditions(
        session,
        audition_ids=audition_ids,
        party_id=args.party,
        difficulty=args.difficulty,
        wait_margin=args.margin,
        notations_dir=args.notations_dir,
        random_ceiling=args.random,
        skip_star_phases=args.no_star,
    )
    print(f"[*] phases cleared: {sum(1 for r in results if r.status == 'ok')}")
    return 0


def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(prog="wds", description="WDS game API toolkit")
    p.add_argument("--version", action="version", version=__version__)
    sub = p.add_subparsers(dest="command", required=True)

    pe = sub.add_parser("fetch-env", help="fetch the environment config")
    _add_common(pe, env=True)
    pe.set_defaults(func=cmd_fetch_env)

    pl = sub.add_parser("login", help="引继/authenticate/login flow")
    _add_common(pl, env=True)
    _token_args(pl)
    pl.add_argument("--linkage-code", help="引继 ID (required on first login)")
    pl.add_argument("--password", help="引继 password (required on first login)")
    pl.add_argument("--apk-hash", default="", help="AuthenticatePayload ApkHash")
    pl.add_argument("--apk-application-signature", default="",
                    help="AuthenticatePayload ApkApplicationSignature")
    pl.add_argument("--app-version", default=None,
                    help="AuthenticatePayload ApplicationVersion (default from Play)")
    pl.add_argument("--compress-auth", action="store_true",
                    help="wrap Authenticate in the ext-98 LZ4 frame like the capture "
                         "(default plain msgpack; the frame is experimental)")
    pl.set_defaults(func=cmd_login)

    pm = sub.add_parser("master-data", help="download and deserialize master data")
    _add_common(pm, env=True)
    _token_args(pm)
    pm.add_argument("--out-dir", default="masterdata")
    pm.add_argument("--db", default=None, help="use an existing .db file (skip download)")
    pm.add_argument("--force", action="store_true")
    pm.add_argument("--indent", type=int, default=2)
    pm.set_defaults(func=cmd_master_data)

    ph = sub.add_parser("decode-har", help="decode all API responses in a HAR")
    _add_common(ph, env=False)
    ph.add_argument("--har", default="wds_2026_08_02_18_43_12.har")
    ph.add_argument("--output", default="apis_decoded.json")
    ph.add_argument("--il2cpp-cs", default="cs/il2cpp.cs")
    ph.add_argument("--il2cpp-json", default="il2cpp.json")
    ph.set_defaults(func=cmd_decode_har)

    ps = sub.add_parser("fetch-scenes", help="download all story scene bins")
    _add_common(ps, env=True)
    _token_args(ps)
    ps.add_argument("--linkage-code", help="引继 ID (if no stored token)")
    ps.add_argument("--password", help="引继 password")
    ps.add_argument("--ids", default=None, help="comma separated episode ids (default: all)")
    ps.add_argument("--masterdata", default="masterdata/tables")
    ps.add_argument("--out-dir", default="scenes")
    ps.add_argument("--concurrency", type=int, default=4,
                    help="parallel scene downloads (default 4; CDN drops "
                         "connections under heavier concurrency)")
    ps.add_argument("--limit", type=int, default=None)
    ps.add_argument("--force", action="store_true")
    ps.set_defaults(func=cmd_fetch_scenes)

    pr = sub.add_parser(
        "story-read",
        help="bulk read main/event/character stories and collect texts",
    )
    _add_common(pr, env=True)
    _credential_args(pr)
    pr.add_argument("--kinds", default="main,event,character",
                    help="comma list: main,event,character,spot,special,all")
    pr.add_argument("--mode", default="both",
                    choices=("read", "readall", "both"),
                    help="Read=normal, ReadAll=skip-all; 'both' sends both "
                         "packets per episode (default)")
    pr.add_argument("--ids", default=None,
                    help="comma separated episode ids (default: all)")
    pr.add_argument("--owned-only", action=argparse.BooleanOptionalAction,
                    default=True,
                    help="only episodes of characters the account owns "
                         "(default; --no-owned-only processes all)")
    pr.add_argument("--all", action="store_true",
                    help="also process already-completed episodes")
    pr.add_argument("--no-release", action="store_true",
                    help="skip ReleaseSideStory for character stories")
    pr.add_argument("--no-texts", action="store_true",
                    help="skip scene text collection")
    pr.add_argument("--masterdata", default="masterdata/tables")
    pr.add_argument("--scenes-dir", default="scenes")
    pr.add_argument("--texts-dir", default="story_texts")
    pr.add_argument("--concurrency", type=int, default=4)
    pr.add_argument("--delay", type=float, default=0.4)
    pr.add_argument("--force-scene", action="store_true",
                    help="re-download scene bins even when present")
    pr.add_argument("--report", default="story_report.json")
    pr.set_defaults(func=cmd_story_read)

    ps2 = sub.add_parser(
        "story-status",
        help="local per-episode completion report (no API writes)",
    )
    _add_common(ps2, env=True)
    ps2.add_argument("--credentials", default="credentials.json")
    ps2.add_argument("--masterdata", default="masterdata/tables")
    ps2.add_argument("--texts-dir", default="story_texts")
    ps2.add_argument("--report", default="story_report.json")
    ps2.set_defaults(func=cmd_story_status)

    plv = sub.add_parser(
        "lives-play",
        help="bulk play every live (song x difficulty) with all-perfect results",
    )
    _add_common(plv, env=True)
    _credential_args(plv)
    plv.add_argument("--masterdata", default="masterdata/tables")
    plv.add_argument("--music", default=None,
                     help="comma separated music ids (default: all)")
    plv.add_argument("--difficulty", type=int, nargs="*", default=None,
                     help="difficulties to play (default: all)")
    plv.add_argument("--party", type=int, default=None,
                     help="fixed party id (default: current party)")
    plv.add_argument("--random-party", action="store_true",
                     help="pick a random preset party (1-4队) for every live")
    plv.add_argument("--party-pool", type=int, default=4,
                     help="use the first N preset parties when --random-party")
    plv.add_argument("--limit", type=int, default=None)
    plv.add_argument("--offset", type=int, default=None)
    plv.add_argument("--margin", type=int, default=30,
                     help="extra seconds to wait beyond the song length")
    plv.add_argument("--notes", type=int, default=500,
                     help="synthetic score-block count (not validated by server)")
    plv.add_argument("--real-chart", action="store_true",
                     help="build blocks from the real notation (notes/notations/) "
                          "with the game's score model")
    plv.add_argument("--notations-dir", default="notations")
    plv.add_argument("--progress", default="lives_progress.json")
    plv.add_argument("--no-resume", action="store_true")
    plv.add_argument("--dry-run", action="store_true",
                     help="list the play order without sending requests")
    plv.add_argument("--daily", action="store_true",
                     help="run the daily cycle after all lives finish")
    plv.add_argument("--daily-ratio", type=int, default=10,
                     help="stamina consumption ratio for the daily cycle")
    plv.add_argument("--daily-max-plays", type=int, default=None)
    plv.add_argument("--wait-day", action="store_true",
                     help="keep running and loop at the 04:00 CST day boundary")
    plv.set_defaults(func=cmd_lives_play)

    pd = sub.add_parser(
        "daily",
        help="daily mode: 10x-stamina lives, story unlock scan, lessons, missions",
    )
    _add_common(pd, env=True)
    _credential_args(pd)
    pd.add_argument("--masterdata", default="masterdata/tables")
    pd.add_argument("--music", default=None)
    pd.add_argument("--party", type=int, default=None)
    pd.add_argument("--ratio", type=int, default=10)
    pd.add_argument("--margin", type=int, default=30)
    pd.add_argument("--notations-dir", default="notations")
    pd.add_argument("--real-chart", action="store_true")
    pd.add_argument("--max-plays", type=int, default=None)
    pd.add_argument("--wait-day", action="store_true")
    pd.add_argument("--state", default="daily_state.json")
    pd.set_defaults(func=cmd_daily)

    pa = sub.add_parser(
        "assets-update",
        help="download/update Addressables asset bundles from the catalogs",
    )
    _add_common(pa, env=True)
    pa.add_argument("--types", default="2d-assets,cri-assets,3d-assets")
    pa.add_argument("--out-dir", default="assets")
    pa.add_argument("--concurrency", type=int, default=8)
    pa.add_argument("--force", action="store_true",
                    help="re-download catalogs and all bundles")
    pa.set_defaults(func=cmd_assets_update)

    pn = sub.add_parser(
        "notation-fetch",
        help="download/decrypt/parse all notation (chart) .enc files",
    )
    _add_common(pn, env=True)
    pn.add_argument("--music", default=None,
                    help="comma separated music ids (default: all)")
    pn.add_argument("--difficulty", default=None,
                    help="comma separated difficulties (default: all)")
    pn.add_argument("--out-dir", default="notations")
    pn.set_defaults(func=cmd_notation_fetch)

    pni = sub.add_parser(
        "notation-index",
        help="build a shareable JSON index of songs/charts with .enc URLs",
    )
    _add_common(pni, env=True)
    pni.add_argument("--asset-url", default=None,
                     help="override the Notation CDN base URL")
    pni.add_argument("--masterdata", default="masterdata/tables")
    pni.add_argument("--notations-dir", default="notations")
    pni.add_argument("--output", default="notations_index.json")
    pni.add_argument("--indent", type=int, default=2)
    pni.set_defaults(func=cmd_notation_index)

    psa = sub.add_parser(
        "static-assets-backup",
        help="back up CDN static assets (Home/Gacha/Notification banners)",
    )
    _add_common(psa, env=True)
    _credential_args(psa)
    psa.add_argument("--masterdata", default="masterdata/tables")
    psa.add_argument("--no-api", action="store_true",
                     help="skip the notifications API banner list")
    psa.add_argument("--output", default="static_assets")
    psa.add_argument("--concurrency", type=int, default=8)
    psa.add_argument("--force", action="store_true")
    psa.set_defaults(func=cmd_static_assets)

    pl2 = sub.add_parser("lessons", help="daily lesson (稽古) bulk play")
    _add_common(pl2, env=True)
    _credential_args(pl2)
    pl2.add_argument("--live", type=int, default=18202)
    pl2.add_argument("--margin", type=int, default=30)
    pl2.add_argument("--notations-dir", default="notations")
    pl2.add_argument("--max-plays", type=int, default=None)
    pl2.set_defaults(func=cmd_lessons)

    pa2 = sub.add_parser(
        "auditions",
        help="audition challenge floors: clear every uncleared phase",
    )
    _add_common(pa2, env=True)
    _credential_args(pa2)
    pa2.add_argument("--ids", default=None)
    pa2.add_argument("--party", type=int, default=None,
                     help="party id to use (default: current party)")
    pa2.add_argument("--difficulty", type=int, default=3)
    pa2.add_argument("--margin", type=int, default=30)
    pa2.add_argument("--notations-dir", default="notations")
    pa2.add_argument("--random", type=int, default=1_000_000)
    pa2.add_argument("--no-star", action="store_true",
                     help="skip 3-star phases (StarActCount) for now")
    pa2.set_defaults(func=cmd_auditions)
    return p


def _add_common(p: argparse.ArgumentParser, *, env: bool) -> None:
    if env:
        p.add_argument("--api-base", default="https://lb-api.wds-stellarium.com")
        p.add_argument("--timeout", type=int, default=60)


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    raise SystemExit(main())
