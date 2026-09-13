from __future__ import annotations

import json
import re
import time
import uuid
import urllib.error
import urllib.request
from pathlib import Path
from typing import Any

CDN_HOST = "https://cdn.resleriana.jp"
CDN_HOSTS = {
    "Japan": "https://asset.resleriana.jp",
    "Global": "https://asset.resleriana.com",
}
GAME_HOST = "https://game.resleriana.jp"
APP_VERSION_SUFFIX = "-3NUUEEU37W7CHV3T"
CATALOG_URL = {
    "Japan": "https://asset.resleriana.jp/asset/{version}/{platform}/catalog.json",
    "Global": "https://asset.resleriana.com/asset/{version}/{platform}/catalog.json",
}
VERSION_RE = re.compile(r"^(\d{9,})_([A-Za-z0-9_\-]{6,})$")

LIST_URLS = (
    f"{CDN_HOST}/?list-type=2&prefix=asset/&delimiter=/",
    f"{CDN_HOST}/?list-type=2&prefix=admin_master_data/&delimiter=/",
    f"{CDN_HOST}/",
)

MIRROR_CONFIG_URLS = (
    "https://raw.githubusercontent.com/theBowja/resleriana-db/main/import/config.json",
    "https://cdn.jsdelivr.net/gh/theBowja/resleriana-db@main/import/config.json",
)


def http_get(url: str, timeout: int = 60, headers: dict[str, str] | None = None) -> bytes:
    req = urllib.request.Request(url, headers=headers or {})
    with urllib.request.urlopen(req, timeout=timeout) as resp: 
        return resp.read()


def http_post(
    url: str,
    body: bytes,
    headers: dict[str, str] | None = None,
    timeout: int = 30,
) -> tuple[int, dict[str, str], bytes]:
    req = urllib.request.Request(url, data=body, method="POST")
    for key, value in (headers or {}).items():
        req.add_header(key, value)
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:  # noqa: S310
            return resp.status, dict(resp.headers), resp.read()
    except urllib.error.HTTPError as exc:
        return exc.code, dict(exc.headers), exc.read()



def load_versions(path: Path) -> dict[str, Any]:
    if path.is_file():
        try:
            data = json.loads(path.read_text(encoding="utf-8"))
            if isinstance(data, dict):
                return data
        except json.JSONDecodeError:
            pass
    return {}


def save_versions(path: Path, data: dict[str, Any]) -> None:
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")



def list_cdn_keys(host: str = CDN_HOST, timeout: int = 60) -> list[str]:
    keys: list[str] = []
    seen: set[str] = set()
    for url in (
        f"{host}/?list-type=2&prefix=asset/&delimiter=/",
        f"{host}/?list-type=2&prefix=admin_master_data/&delimiter=/",
        f"{host}/",
    ):
        try:
            text = http_get(url, timeout=timeout).decode("utf-8", "replace")
        except Exception:  # noqa: BLE001
            continue
        found = re.findall(r"<Key>(.*?)</Key>", text, re.S)
        found += [p.rstrip("/") for p in re.findall(r"<CommonPrefixes>\s*<Prefix>(.*?)</Prefix>", text, re.S)]
        for key in found:
            key = key.strip()
            if key and key not in seen:
                seen.add(key)
                keys.append(key)
    return keys


def parse_versions_from_keys(keys: list[str]) -> dict[str, str]:
    """从 S3 key 列表里挑出最新的 masterdata / fileassets 版本。"""
    master: list[tuple[int, str]] = []
    assets: list[tuple[int, str]] = []
    for key in keys:
        if key.startswith("admin_master_data/") or key.startswith("master_data/"):
            version = key.split("/", 1)[1].strip("/")
            match = VERSION_RE.match(version)
            if match:
                master.append((int(match.group(1)), version))
        elif key.startswith("asset/"):
            parts = key.split("/")
            if len(parts) >= 2:
                match = VERSION_RE.match(parts[1])
                if match:
                    assets.append((int(match.group(1)), parts[1]))
    out: dict[str, str] = {}
    if master:
        out["masterdata_version"] = max(master)[1]
    if assets:
        out["fileassets_version"] = max(assets)[1]
    return out


def fetch_mirror_versions(server: str, timeout: int = 20) -> dict[str, str]:
    for url in MIRROR_CONFIG_URLS:
        try:
            data = json.loads(http_get(url, timeout=timeout, headers={"User-Agent": "Mozilla/5.0"}))
        except Exception:  # noqa: BLE001
            continue
        out: dict[str, str] = {}
        for source, dest in (
            ("fileassets_version", "fileassets_version"),
            ("masterdata_version", "masterdata_version"),
        ):
            value = (data.get(source) or {})
            if isinstance(value, dict) and isinstance(value.get(server), str) and value[server]:
                out[dest] = value[server]
        if out:
            return out
    return {}


def probe_catalog(server: str, version: str, platform: str = "Android") -> bool:
    url = CATALOG_URL[server].format(version=version, platform=platform)
    try:
        http_get(url, timeout=30)
        return True
    except Exception:  # noqa: BLE001
        return False


def _stamp(version: str) -> int:
    match = VERSION_RE.match(version or "")
    return int(match.group(1)) if match else 0


def is_stale_asset_version(asset_version: str, master_version: str, slack_days: int = 45) -> bool:
    asset_ts, master_ts = _stamp(asset_version), _stamp(master_version)
    return bool(asset_ts and master_ts and master_ts - asset_ts > slack_days * 86400)



def _pb_string(field: int, value: str) -> bytes:
    raw = value.encode("utf-8")
    return bytes([field << 3 | 2, len(raw)]) + raw


def _pb_varint(field: int, value: int) -> bytes:
    out = bytearray([field << 3 | 0])
    while True:
        chunk = value & 0x7F
        value >>= 7
        if value:
            out.append(chunk | 0x80)
        else:
            out.append(chunk)
            break
    return bytes(out)


def _api_headers(asset_version: str = "", master_version: str = "") -> dict[str, str]:
    return {
        "Content-Type": "application/octet-stream",
        "x-client-version": "2.16.5" + APP_VERSION_SUFFIX,
        "x-platform": "android",
        "x-request-timestamp": str(int(time.time() * 1000)),
        "x-request-id": str(uuid.uuid4()),
        "x-asset-version": asset_version,
        "x-master-data-version": master_version,
    }


def _extract_versions(status: int, headers: dict[str, str], body: bytes) -> dict[str, str]:
    out: dict[str, str] = {}
    for key, value in headers.items():
        low = key.lower()
        if low == "x-asset-version":
            out["fileassets_version"] = value.strip()
        elif low == "x-master-data-version":
            out["masterdata_version"] = value.strip()
    if not out:
        try:
            data = json.loads(body.decode("utf-8"))
        except Exception:  # noqa: BLE001
            data = {}
        if isinstance(data, dict):
            for src, dest in (
                ("asset_version", "fileassets_version"),
                ("fileassets_version", "fileassets_version"),
                ("master_data_version", "masterdata_version"),
                ("masterdata_version", "masterdata_version"),
                ("pre_download_asset_version", "fileassets_version"),
                ("pre_download_master_data_version", "masterdata_version"),
            ):
                if isinstance(data.get(src), str) and data[src]:
                    out.setdefault(dest, data[src])
    return out


def login_versions(
    identity: dict[str, str],
    *,
    asset_version: str = "",
    master_version: str = "",
) -> dict[str, str]:
    unique_id = identity.get("device_unique_id") or str(uuid.uuid4())
    secret = identity.get("device_secret") or str(uuid.uuid4())
    identity["device_unique_id"] = unique_id
    identity["device_secret"] = secret
    headers = _api_headers(asset_version, master_version)

    body = (
        _pb_string(1, secret)
        + _pb_string(2, unique_id)
        + _pb_string(3, identity.get("device_model", "Android SDK built for x86_64"))
        + _pb_varint(4, int(identity.get("language", 1)))
    )
    status, resp_headers, resp_body = http_post(f"{GAME_HOST}/auth/sign_up", body, headers)
    found = _extract_versions(status, resp_headers, resp_body)
    if not found:
        status, resp_headers, resp_body = http_post(f"{GAME_HOST}/user/log_in", b"", headers)
        found = _extract_versions(status, resp_headers, resp_body)
    if not found:
        raise RuntimeError(f"登录成功但响应里没有版本号（HTTP {status}）")
    return found


def resolve(
    server: str,
    *,
    fileassets_version: str = "",
    masterdata_version: str = "",
    cache_path: Path | None = None,
    use_cdn: bool = True,
    use_mirror: bool = True,
    use_login: bool = False,
    platform: str = "Android",
    on_info: Any | None = None,
) -> dict[str, str]:
    """返回 {"fileassets_version": ..., "masterdata_version": ...}。"""
    def note(message: str) -> None:
        if on_info is not None:
            on_info(message)

    cached = load_versions(cache_path) if cache_path else {}
    entry = cached.get(server, {}) if isinstance(cached.get(server), dict) else {}
    result = {
        "fileassets_version": fileassets_version
        or entry.get("fileassets_version", "")
        or cached.get("fileassets_version", ""),
        "masterdata_version": masterdata_version
        or entry.get("masterdata_version", "")
        or cached.get("masterdata_version", ""),
    }

    if use_cdn and not all(result.values()):
        note("从 CDN 列表推断版本 …")
        try:
            keys = list_cdn_keys()
            parsed = parse_versions_from_keys(keys)
            for key, value in parsed.items():
                if not result.get(key):
                    result[key] = value
            note(f"  CDN 列表命中 {len(keys)} 个 key：{parsed or '无'}")
        except Exception as exc:  # noqa: BLE001
            note(f"  CDN 列表失败：{exc}")

    if not fileassets_version and is_stale_asset_version(
        result.get("fileassets_version", ""), result.get("masterdata_version", "")
    ):
        result["fileassets_version"] = ""


    if use_mirror and not result["fileassets_version"]:
        note("尝试社区版本镜像 …")
        try:
            mirrored = fetch_mirror_versions(server)
        except Exception as exc:  # noqa: BLE001
            mirrored = {}
            note(f"  镜像失败：{exc}")
        candidate = mirrored.get("fileassets_version", "")
        if candidate and probe_catalog(server, candidate, platform):
            result["fileassets_version"] = candidate
            note(f"  镜像 fileassets_version = {candidate}（已校验）")
        elif candidate:
            note(f"  镜像版本 {candidate} 取不到 catalog，忽略")
        if not result["masterdata_version"] and mirrored.get("masterdata_version"):
            result["masterdata_version"] = mirrored["masterdata_version"]

    if use_login and not all(result.values()):
        note("尝试 guest 登录取版本 …")
        found = login_versions(
            entry,
            asset_version=result["fileassets_version"],
            master_version=result["masterdata_version"],
        )
        for key, value in found.items():
            if not result.get(key):
                result[key] = value

    if result["fileassets_version"]:
        ok = probe_catalog(server, result["fileassets_version"], platform)
        if not ok:
            note(f"  警告：{server} {result['fileassets_version']} 取不到 catalog.json")

    if cache_path is not None:
        cached[server] = {
            "fileassets_version": result["fileassets_version"],
            "masterdata_version": result["masterdata_version"],
            "updated_at": int(time.time()),
            **{k: v for k, v in entry.items() if k.startswith("device_")},
        }
        save_versions(cache_path, cached)
    return result
