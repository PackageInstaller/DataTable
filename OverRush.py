from __future__ import annotations

import argparse
import gzip
import io
import json
import os
import random
import re
import shutil
import struct
import sys
import tempfile
import time
import uuid
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Iterable
from urllib.parse import urlparse

import requests
import UnityPy
from Crypto.Cipher import AES, PKCS1_v1_5
from Crypto.PublicKey import RSA
from Crypto.Util.Padding import pad, unpad
from rich.console import Console
from rich.progress import BarColumn, Progress, TextColumn, TimeRemainingColumn

from UnityCatalogReader import UnityCatalogReader

console = Console()

SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
IL2CPP_CS = SCRIPT_DIR / "cs" / "il2cpp.cs"

API_BASE = "https://game.over-rush.com"
CDN_BASE = "https://cdn.over-rush.com"
APP_VER = "0.1.3"
OS_TYPE = 2  # OsType.Android
STORE_TYPE = 2  # StoreType.GooglePlay
TIMEZONE_ID = "Local"
RUSH_VER = f"{OS_TYPE}_{APP_VER}"
CATALOG_REL = f"assetbundles/release/android/{APP_VER}/catalog_{APP_VER}.json"
KEY_ID_INVALID = -1
RSA_BITS = 1024
DEFAULT_JOBS = 8
CHUNK = 1 << 20
CDN_HEADERS: dict[str, str] = {}

# AppURLConfig.legalServerUrlEntries：非 Real 的 CDN 要带 Validation-Header
ENVS: dict[str, dict[str, str]] = {
    "real": {
        "cdn": "https://cdn.over-rush.com",
        "header": "",
        "catalog": f"assetbundles/release/android/{APP_VER}/catalog_{APP_VER}.json",
        "dest": "Assets",
    },
    "local": {
        "cdn": "https://cdn-dev.rush.pa-hi-works.com",
        "header": "2smKT9gEu48AAJtiETw2",
        "catalog": "assetbundles/develop/android/0.1.0/catalog_0.1.0.json",
        "dest": "Assets_Dev",
    },
    "dev": {
        "cdn": "https://cdn-dev.rush.pa-hi-works.com",
        "header": "2smKT9gEu48AAJtiETw2",
        "catalog": "assetbundles/develop/android/0.1.0/catalog_0.1.0.json",
        "dest": "Assets_Dev",
    },
    "qa1": {
        "cdn": "https://cdn-qa1.rush.pa-hi-works.com",
        "header": "s8SyPWAzGhGgLTEjNUWG",
        "catalog": "",
        "dest": "Assets_QA1",
    },
    "qa2": {
        "cdn": "https://cdn-qa2.rush.pa-hi-works.com",
        "header": "nkBpPxw7YHRnZFgL73Qc",
        "catalog": "",
        "dest": "Assets_QA2",
    },
    "sandbox": {
        "cdn": "https://cdn-sandbox.rush.pa-hi-works.com",
        "header": "oiYVla0Pbwi2f5PD5L3q",
        "catalog": "",
        "dest": "Assets_Sandbox",
    },
}

MASTER_FILE_PASSWORD = "OverRush"

HTTP_HEADERS = {
    "User-Agent": "UnityPlayer/6000.3.19f1 (UnityWebRequest/1.0, libcurl/8.10.1-DEV)",
    "Accept": "*/*",
    "Content-Type": "application/octet-stream",
    "Accept-Encoding": "identity",
    "Rush-Ver": RUSH_VER,
    "X-Unity-Version": "6000.3.19f1",
}


def _rotl8(b: int, n: int) -> int:
    n &= 7
    return ((b << n) | (b >> ((-n) & 7))) & 0xFF


def _rotr8(b: int, n: int) -> int:
    n &= 7
    return ((b >> n) | (b << ((-n) & 7))) & 0xFF


def seekable_decrypt(data: bytes, key: bytes, pos: int = 0) -> bytes:
    """SeekableCryptStream.Decrypt"""
    if len(key) < 16:
        raise ValueError("decryptKey 需要 16 字节")
    out = bytearray(data)
    for i, b in enumerate(out):
        p = pos + i
        out[i] = key[p & 0xF] ^ _rotl8(b, p)
    return bytes(out)


def seekable_encrypt(data: bytes, key: bytes, pos: int = 0) -> bytes:
    out = bytearray(data)
    for i, b in enumerate(out):
        p = pos + i
        out[i] = _rotr8(key[p & 0xF] ^ b, p)
    return bytes(out)


def looks_unityfs(data: bytes) -> bool:
    return data.startswith(b"UnityFS")


def as_decrypt_key(raw: Any) -> bytes | None:
    if raw is None:
        return None
    if isinstance(raw, (bytes, bytearray)):
        return bytes(raw)
    if isinstance(raw, list) and raw and all(isinstance(x, int) for x in raw):
        return bytes(x & 0xFF for x in raw)
    if isinstance(raw, str):
        try:
            return bytes.fromhex(raw)
        except ValueError:
            return None
    return None


def master_cache_key(password: str, file_name: str, key_size: int = 32) -> bytes:
    """FileOperator.GenerateKey：SHA1(UTF8(salt)) → Rfc2898(password, hash, 1000, SHA1)"""
    from hashlib import pbkdf2_hmac, sha1

    salt = sha1(file_name.encode("utf-8")).digest()
    return pbkdf2_hmac("sha1", password.encode("utf-8"), salt, 1000, dklen=key_size)


def master_cache_decrypt(blob: bytes, password: str, file_name: str) -> bytes:
    key = master_cache_key(password, file_name, 32)
    iv, ct = blob[:16], blob[16:]
    plain = unpad(AES.new(key, AES.MODE_CBC, iv).decrypt(ct), 16)
    return gzip.decompress(plain)


def _varint_enc(n: int) -> bytes:
    n &= (1 << 64) - 1
    out = bytearray()
    while n > 0x7F:
        out.append((n & 0x7F) | 0x80)
        n >>= 7
    out.append(n)
    return bytes(out)


def _varint_dec(buf: bytes, i: int) -> tuple[int, int]:
    x = s = 0
    while True:
        if i >= len(buf):
            raise ValueError("truncated varint")
        b = buf[i]
        i += 1
        x |= (b & 0x7F) << s
        if b < 0x80:
            return x, i
        s += 7
        if s >= 64:
            raise ValueError("varint too long")


def pb_field(fn: int, wt: int, payload: bytes) -> bytes:
    return _varint_enc((fn << 3) | wt) + payload


def pb_bytes(fn: int, data: bytes) -> bytes:
    return pb_field(fn, 2, _varint_enc(len(data)) + data)


def pb_str(fn: int, s: str) -> bytes:
    return pb_bytes(fn, s.encode("utf-8"))


def pb_varint(fn: int, n: int) -> bytes:
    return pb_field(fn, 0, _varint_enc(n))


def pb_delimited(msg: bytes) -> bytes:
    return _varint_enc(len(msg)) + msg


def pb_walk(buf: bytes) -> list[tuple[int, int, bytes | int]]:
    i = 0
    out: list[tuple[int, int, bytes | int]] = []
    while i < len(buf):
        tag, i = _varint_dec(buf, i)
        fn, wt = tag >> 3, tag & 7
        if wt == 0:
            v, i = _varint_dec(buf, i)
            out.append((fn, wt, v))
        elif wt == 1:
            out.append((fn, wt, buf[i : i + 8]))
            i += 8
        elif wt == 2:
            ln, i = _varint_dec(buf, i)
            out.append((fn, wt, buf[i : i + ln]))
            i += ln
        elif wt == 5:
            out.append((fn, wt, buf[i : i + 4]))
            i += 4
        else:
            break
    return out


def _maybe_utf8(data: bytes) -> str | None:
    if not data:
        return ""
    if b"\x00" in data:
        return None
    try:
        s = data.decode("utf-8")
    except UnicodeDecodeError:
        return None
    if any(ord(c) < 9 and c not in "\t\n\r" for c in s):
        return None
    return s


def _looks_msg(data: bytes) -> bool:
    if not data:
        return False
    try:
        i = 0
        n = 0
        while i < len(data):
            tag, i = _varint_dec(data, i)
            fn, wt = tag >> 3, tag & 7
            if fn == 0:
                return False
            if wt == 0:
                _, i = _varint_dec(data, i)
            elif wt == 1:
                i += 8
            elif wt == 2:
                ln, i = _varint_dec(data, i)
                i += ln
            elif wt == 5:
                i += 4
            else:
                return False
            n += 1
        return n > 0 and i == len(data)
    except Exception:
        return False


def pb_to_obj(buf: bytes, names: dict[int, str] | None = None) -> Any:
    """无 schema 的 protobuf → JSON"""
    grouped: dict[int, list[Any]] = {}
    for fn, wt, val in pb_walk(buf):
        if wt == 0:
            item: Any = val
        elif wt in (1, 5):
            item = int.from_bytes(val, "little", signed=False) if isinstance(val, bytes) else val
        else:
            assert isinstance(val, bytes)
            text = _maybe_utf8(val)
            if text is not None:
                item = text
            elif _looks_msg(val):
                item = pb_to_obj(val, None)
            else:
                item = {"$hex": val.hex()}
        grouped.setdefault(fn, []).append(item)

    obj: dict[str, Any] = {}
    for fn, items in grouped.items():
        key = (names or {}).get(fn, f"_{fn}")
        obj[key] = items[0] if len(items) == 1 else items
    return obj


_SCHEMA: dict[str, dict[int, str]] | None = None


def load_field_names(cs_path: Path = IL2CPP_CS) -> dict[str, dict[int, str]]:
    """从 il2cpp.cs 抽 class"""
    global _SCHEMA
    if _SCHEMA is not None:
        return _SCHEMA
    schema: dict[str, dict[int, str]] = {}
    current = ""
    class_re = re.compile(
        r"^\s*(?:public |internal |protected |private |sealed |abstract |static )*class (\w+)\b"
    )
    field_re = re.compile(r"public const int (\w+)FieldNumber = (\d+);")
    if not cs_path.exists():
        _SCHEMA = schema
        return schema
    with cs_path.open("r", encoding="utf-8", errors="ignore") as fh:
        for line in fh:
            m = class_re.match(line)
            if m:
                current = m.group(1)
                continue
            m = field_re.search(line)
            if m and current:
                schema.setdefault(current, {})[int(m.group(2))] = _camel(m.group(1))
    _SCHEMA = schema
    return schema


def _camel(name: str) -> str:
    if not name:
        return name
    return name[0].lower() + name[1:]


def snake_to_pascal(name: str) -> str:
    if "_" in name:
        return "".join(p[:1].upper() + p[1:] for p in name.split("_") if p)
    return name[:1].upper() + name[1:] if name else name


def table_list_type(name: str) -> str:
    pascal = snake_to_pascal(name)
    return pascal if pascal.endswith("List") else pascal + "List"


def maybe_gunzip(blob: bytes) -> bytes:
    if blob[:2] == b"\x1f\x8b":
        return gzip.decompress(blob)
    return blob


def decode_named(buf: bytes, type_name: str) -> Any:
    names = load_field_names().get(type_name)
    obj = pb_to_obj(buf, names)
    if type_name.endswith("List") and isinstance(obj, dict) and len(obj) == 1:
        only = next(iter(obj.values()))
        row_type = type_name[: -len("List")]
        row_names = load_field_names().get(row_type)
        if isinstance(only, list) and row_names:
            return [_rename_deep(x, row_names) if isinstance(x, dict) else x for x in only]
        if isinstance(only, dict) and row_names:
            return [_rename_deep(only, row_names)]
        return only
    return obj


def _rename_deep(obj: Any, names: dict[int, str]) -> Any:
    if not isinstance(obj, dict):
        return obj
    out = {}
    for k, v in obj.items():
        if k.startswith("_") and k[1:].isdigit():
            nk = names.get(int(k[1:]), k)
        else:
            nk = k
        out[nk] = v
    return out


def encode_session(app_ver: str = APP_VER) -> bytes:
    return (
        pb_str(4, app_ver)
        + pb_varint(5, OS_TYPE)
        + pb_varint(17, STORE_TYPE)
        + pb_str(20, TIMEZONE_ID)
    )


def rsa_public_xml(key: RSA.RsaKey) -> str:
    n = key.n.to_bytes((key.n.bit_length() + 7) // 8, "big")
    e = key.e.to_bytes((key.e.bit_length() + 7) // 8, "big")
    import base64

    return (
        "<RSAKeyValue>"
        f"<Modulus>{base64.b64encode(n).decode()}</Modulus>"
        f"<Exponent>{base64.b64encode(e).decode()}</Exponent>"
        "</RSAKeyValue>"
    )


def api_pack(session: bytes, body: bytes, key_id: int, aes_key: bytes | None) -> bytes:
    payload = gzip.compress(pb_delimited(session) + pb_delimited(body), mtime=0)
    head = struct.pack("<i", key_id)
    if aes_key is None:
        return head + payload
    iv = os.urandom(16)
    cipher = AES.new(aes_key, AES.MODE_CBC, iv)
    return head + iv + cipher.encrypt(pad(payload, 16))


def api_unpack(blob: bytes, aes_key: bytes | None) -> tuple[int, bytes, bytes]:
    if len(blob) < 4:
        raise ValueError("回包太短")
    key_id = struct.unpack_from("<i", blob)[0]
    rest = blob[4:]
    if aes_key is not None:
        if len(rest) < 32:
            raise ValueError("AES 回包太短")
        iv, ct = rest[:16], rest[16:]
        rest = unpad(AES.new(aes_key, AES.MODE_CBC, iv).decrypt(ct), 16)
    plain = gzip.decompress(rest)
    i = 0
    ln, i = _varint_dec(plain, i)
    session = plain[i : i + ln]
    i += ln
    ln, i = _varint_dec(plain, i)
    body = plain[i : i + ln]
    return key_id, session, body


def api_post(path: str, blob: bytes, timeout: int = 60) -> bytes:
    url = API_BASE.rstrip("/") + "/" + path.lstrip("/")
    r = requests.post(url, data=blob, headers=HTTP_HEADERS, timeout=timeout)
    r.raise_for_status()
    return r.content


def fetch_master_tables(app_ver: str = APP_VER) -> tuple[dict[str, Any], dict[str, bytes]]:
    """getKey + getInit，返回 (session_json, {tableName: dataBytes})"""
    rsa = RSA.generate(RSA_BITS)
    session = encode_session(app_ver)
    req_key = pb_str(1, rsa_public_xml(rsa))
    raw = api_post("getKey", api_pack(session, req_key, KEY_ID_INVALID, None))
    key_id, sess, body = api_unpack(raw, None)
    enc_key = None
    for fn, wt, val in pb_walk(body):
        if fn == 1 and wt == 2 and isinstance(val, bytes):
            enc_key = val
    if not enc_key:
        raise RuntimeError("getKey 没有 EncKey")
    sentinel = os.urandom(16)
    dec = PKCS1_v1_5.new(rsa).decrypt(enc_key, sentinel)
    if dec is sentinel or len(dec) not in (16, 24, 32):
        raise RuntimeError(f"RSA 解开的 AES key 异常: {None if dec is sentinel else len(dec)}")
    aes_key = dec
    console.print(f"[green]getKey[/] keyId={key_id} aes={len(aes_key)}B")

    uid = str(uuid.uuid4())
    req_init = pb_str(1, uid)
    raw = api_post("getInit", api_pack(session, req_init, key_id, aes_key))
    key_id, sess, body = api_unpack(raw, aes_key)
    sess_obj = decode_named(sess, "Session")
    tables: dict[str, bytes] = {}
    versions: dict[str, int] = {}
    extra: dict[str, Any] = {}
    for fn, wt, val in pb_walk(body):
        if fn == 4 and wt == 2 and isinstance(val, bytes):
            name, data, ver = _split_master_table(val)
            tables[name] = data
            versions[name] = ver
        elif fn == 1 and wt == 0:
            extra["termsAt"] = val
        elif fn == 2 and wt == 0:
            extra["masterVersion"] = val
        elif fn == 3 and wt == 0:
            extra["userId"] = val
        elif fn == 5 and wt == 0:
            extra["loginAt"] = val
        elif fn == 6 and wt == 2 and isinstance(val, bytes):
            extra["linkedAccountId"] = val.decode("utf-8", "replace")
    if not tables:
        raise RuntimeError(f"getInit 没有 MasterDataTableList session={sess_obj}")
    meta = {
        "keyId": key_id,
        "uuid": uid,
        "session": sess_obj,
        "init": extra,
        "tableVersions": versions,
        "tables": sorted(tables),
    }
    console.print(f"[green]getInit[/] tables={len(tables)} masterVersion={extra.get('masterVersion')}")
    return meta, tables


def _split_master_table(msg: bytes) -> tuple[str, bytes, int]:
    name, data, ver = "unknown", b"", 0
    for fn, wt, val in pb_walk(msg):
        if fn == 1 and wt == 2 and isinstance(val, bytes):
            name = val.decode("utf-8", "replace")
        elif fn == 2 and wt == 0 and isinstance(val, int):
            ver = val
        elif fn == 3 and wt == 2 and isinstance(val, bytes):
            data = val
    return name, data, ver


def cdn_headers() -> dict[str, str]:
    h = {"User-Agent": HTTP_HEADERS["User-Agent"]}
    h.update(CDN_HEADERS)
    return h


def apply_env(name: str, dest: str = "", catalog_rel: str = "") -> None:
    """按 AppURLConfig 环境切 CDN / Validation-Header / catalog 路径"""
    global CDN_BASE, CATALOG_REL, ASSETS_DIR
    key = name.lower()
    if key not in ENVS:
        raise SystemExit(f"未知环境 {name}，可选: {', '.join(ENVS)}")
    env = ENVS[key]
    CDN_BASE = env["cdn"]
    CATALOG_REL = catalog_rel or env["catalog"]
    CDN_HEADERS.clear()
    if env["header"]:
        CDN_HEADERS["Validation-Header"] = env["header"]
    ASSETS_DIR = Path(dest).resolve() if dest else SCRIPT_DIR / env["dest"]
    if not CATALOG_REL:
        raise SystemExit(f"{name} 的 catalog 路径未知，用 --catalog-rel 指定")



def default_apk() -> Path | None:
    cands = sorted(SCRIPT_DIR.glob("*.apks")) + sorted(SCRIPT_DIR.glob("*.apk"))
    return cands[0] if cands else None


def iter_apk_files(apk_path: Path) -> Iterable[tuple[str, bytes]]:
    """yield (inner_name, data)；apks 先拆 base.apk"""
    if apk_path.suffix.lower() == ".apks":
        with zipfile.ZipFile(apk_path) as outer:
            base = outer.read("base.apk")
        zf = zipfile.ZipFile(io.BytesIO(base))
    else:
        zf = zipfile.ZipFile(apk_path)
    with zf:
        for name in zf.namelist():
            yield name, zf.read(name)


def extract_apk_aa(apk_path: Path, dest: Path) -> Path:
    dest.mkdir(parents=True, exist_ok=True)
    catalog_path = dest / "catalog.json"
    n = 0
    for name, data in iter_apk_files(apk_path):
        if not name.startswith("assets/aa/"):
            continue
        rel = name[len("assets/aa/") :]
        if not rel or rel.endswith("/"):
            continue
        out = dest / Path(rel).name if rel.endswith(".bundle") else dest / rel
        out.parent.mkdir(parents=True, exist_ok=True)
        if out.exists() and (looks_unityfs(out.read_bytes()[:8]) or out.stat().st_size == len(data)):
            n += 1
            continue
        out.write_bytes(data)
        n += 1
    console.print(f"[green]APK aa/[/] {n} 个 → {dest}")
    return catalog_path if catalog_path.exists() else dest / "catalog.json"


def fetch_remote_catalog(dest: Path, cdn: str = CDN_BASE) -> Path:
    dest.mkdir(parents=True, exist_ok=True)
    url = f"{cdn.rstrip('/')}/{CATALOG_REL}"
    r = requests.get(url, headers=cdn_headers(), timeout=60)
    r.raise_for_status()
    path = dest / "catalog.json"
    path.write_bytes(r.content)
    console.print(f"[green]catalog[/] {len(r.content)}B {url}")
    hash_url = url.rsplit(".", 1)[0] + ".hash"
    try:
        hr = requests.get(hash_url, headers=cdn_headers(), timeout=30)
        if hr.ok:
            (dest / "catalog.hash").write_bytes(hr.content)
    except Exception:
        pass
    return path


def load_catalog(path: Path) -> UnityCatalogReader:
    console.print(f"解析 catalog: {path}")
    return UnityCatalogReader(str(path))


def resolve_bundle_url(internal_id: str, cdn: str = CDN_BASE) -> str:
    url = internal_id.replace("{RuntimeCdnServerUrl}", cdn.rstrip("/"))
    url = url.replace("{UnityEngine.AddressableAssets.Addressables.RuntimePath}", "")
    return url


def is_http(url: str) -> bool:
    return url.startswith("http://") or url.startswith("https://")


def flatten_bundles(root: Path) -> int:
    n = 0
    for p in root.rglob("*.bundle"):
        if p.parent == root:
            continue
        dest = root / p.name
        if not dest.exists():
            shutil.move(str(p), dest)
            n += 1
    return n


def collect_bundles(reader: UnityCatalogReader, cdn: str = CDN_BASE) -> list[dict[str, Any]]:
    seen: set[str] = set()
    items: list[dict[str, Any]] = []
    for loc in reader.get_all_locations():
        iid = loc.internal_id or ""
        if ".bundle" not in iid:
            continue
        url = resolve_bundle_url(iid, cdn)
        name = urlparse(url).path.rsplit("/", 1)[-1]
        if not name or name in seen:
            continue
        seen.add(name)
        data = loc.data if isinstance(loc.data, dict) else {}
        key = as_decrypt_key(data.get("decryptKey") or data.get("DecryptKey"))
        items.append(
            {
                "name": name,
                "url": url,
                "remote": is_http(url),
                "size": int(data.get("m_BundleSize") or loc.bundle_size or 0),
                "hash": data.get("m_Hash") or loc.hash or "",
                "key": key,
            }
        )
    return items


def download_one(item: dict[str, Any], dest: Path, timeout: int = 60) -> str:
    dest.parent.mkdir(parents=True, exist_ok=True)
    expect = item["size"]
    if dest.exists() and expect and dest.stat().st_size == expect:
        return "skip"
    last: Exception | None = None
    for attempt in range(4):
        tmp = dest.with_suffix(dest.suffix + ".part")
        try:
            with requests.get(
                item["url"],
                stream=True,
                timeout=timeout,
                headers=cdn_headers(),
            ) as r:
                r.raise_for_status()
                with tmp.open("wb") as fh:
                    for chunk in r.iter_content(CHUNK):
                        if chunk:
                            fh.write(chunk)
            got = tmp.stat().st_size
            if expect and got != expect:
                tmp.unlink(missing_ok=True)
                raise RuntimeError(f"size {got} != {expect}")
            tmp.replace(dest)
            return "ok"
        except Exception as exc:
            last = exc
            tmp.unlink(missing_ok=True)
            time.sleep(0.4 * (attempt + 1))
    raise last if last else RuntimeError("download failed")


def decrypt_bundle_file(path: Path, key: bytes | None) -> str:
    data = path.read_bytes()
    if looks_unityfs(data):
        return "plain"
    if not key:
        return "no-key"
    plain = seekable_decrypt(data, key)
    if not looks_unityfs(plain):
        return "fail"
    path.write_bytes(plain)
    return "decrypted"


def cmd_assets(args: argparse.Namespace) -> int:
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    apk = Path(args.apk) if args.apk else default_apk()
    catalog_path = ASSETS_DIR / "catalog.json"
    if getattr(args, "env", "real").lower() == "real" and apk and apk.exists():
        extract_apk_aa(apk, ASSETS_DIR)
    try:
        fetch_remote_catalog(ASSETS_DIR, args.cdn)
    except Exception as exc:
        if not catalog_path.exists():
            console.print(f"[red]catalog 拉取失败[/] {exc}")
            return 1
        console.print(f"[yellow]远程 catalog 失败，用本地[/] {exc}")
    if not catalog_path.exists():
        console.print("[red]没有 catalog.json，先给 --apk 或能访问 CDN[/red]")
        return 1

    reader = load_catalog(catalog_path)
    items = collect_bundles(reader, args.cdn)
    console.print(f"catalog bundles {len(items)}")

    moved = flatten_bundles(ASSETS_DIR)
    if moved:
        console.print(f"[green]flatten[/] {moved} 个本地 bundle → {ASSETS_DIR}")

    todo = []
    for it in items:
        dest = ASSETS_DIR / it["name"]
        if dest.exists():
            head = dest.read_bytes()[:8]
            if looks_unityfs(head):
                continue
            if it["size"] and dest.stat().st_size == it["size"]:
                continue
        if not it.get("remote", is_http(it["url"])):
            continue
        todo.append(it)

    console.print(f"待下载 {len(todo)}")
    ok = skip = fail = 0
    if todo:
        with Progress(
            TextColumn("{task.description}"),
            BarColumn(),
            TextColumn("{task.completed}/{task.total}"),
            TimeRemainingColumn(),
            console=console,
        ) as progress:
            task = progress.add_task("download", total=len(todo))

            def _job(it: dict[str, Any]) -> str:
                return download_one(it, ASSETS_DIR / it["name"])

            with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as pool:
                futs = {pool.submit(_job, it): it for it in todo}
                for fut in as_completed(futs):
                    it = futs[fut]
                    try:
                        st = fut.result()
                        if st == "skip":
                            skip += 1
                        else:
                            ok += 1
                    except Exception as exc:
                        fail += 1
                        console.print(f"[yellow]下载失败[/] {it['name']}: {exc}")
                    progress.advance(task)
    console.print(f"[green]下载[/] ok={ok} skip={skip} fail={fail}")

    dec_ok = dec_plain = dec_fail = 0
    with Progress(
        TextColumn("{task.description}"),
        BarColumn(),
        TextColumn("{task.completed}/{task.total}"),
        console=console,
    ) as progress:
        task = progress.add_task("decrypt", total=len(items))
        for it in items:
            path = ASSETS_DIR / it["name"]
            if not path.exists():
                dec_fail += 1
                progress.advance(task)
                continue
            st = decrypt_bundle_file(path, it["key"])
            if st in ("decrypted",):
                dec_ok += 1
            elif st == "plain":
                dec_plain += 1
            else:
                dec_fail += 1
            progress.advance(task)
    console.print(f"[green]解密[/] decrypted={dec_ok} already={dec_plain} fail={dec_fail} → {ASSETS_DIR}")
    return 0 if dec_fail == 0 or dec_ok + dec_plain > 0 else 1



def write_json(path: Path, obj: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def export_tables_from_api(app_ver: str) -> int:
    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    meta, tables = fetch_master_tables(app_ver)
    write_json(MASTER_DIR / "_init.json", meta)
    n = 0
    for name, blob in tables.items():
        raw = maybe_gunzip(blob)
        if not raw:
            obj: Any = []
        else:
            obj = decode_named(raw, table_list_type(name))
        write_json(MASTER_DIR / f"{name}.json", obj)
        n += 1
    console.print(f"[green]MasterData[/] {n} 张表 → {MASTER_DIR}")
    return n


def _py_attr(obj: Any, *names: str, default: Any = None) -> Any:
    for n in names:
        if obj is None:
            break
        if isinstance(obj, dict) and n in obj:
            return obj[n]
        if hasattr(obj, n):
            return getattr(obj, n)
    return default


def load_shared_keys(assets: Path) -> dict[int, str]:
    keys: dict[int, str] = {}
    for bp in assets.glob("*shareddata*.bundle"):
        try:
            env = UnityPy.load(str(bp))
        except Exception:
            continue
        for obj in env.objects:
            if obj.type.name != "MonoBehaviour":
                continue
            try:
                data = obj.read()
            except Exception:
                continue
            entries = _py_attr(data, "m_Entries")
            if not entries:
                continue
            for e in entries:
                kid = _py_attr(e, "m_Id")
                key = _py_attr(e, "m_Key")
                if kid is not None and key:
                    keys[int(kid)] = str(key)
    return keys


def export_string_tables(assets: Path) -> int:
    """从已解密 bundle 里抽 Unity Localization StringTable"""
    loc_dir = MASTER_DIR / "localization"
    key_map = load_shared_keys(assets)
    bundles = sorted(assets.glob("*localization-string-tables*.bundle"))
    n = 0
    for bp in bundles:
        try:
            env = UnityPy.load(str(bp))
        except Exception as exc:
            console.print(f"[yellow]UnityPy[/] {bp.name}: {exc}")
            continue
        for obj in env.objects:
            if obj.type.name != "MonoBehaviour":
                continue
            try:
                data = obj.read()
                entries = _py_attr(data, "m_TableData")
                if not entries:
                    continue
                locale = _py_attr(_py_attr(data, "m_LocaleId"), "m_Code")
                name = _py_attr(data, "m_Name") or bp.stem
                rows = []
                for e in entries:
                    kid = _py_attr(e, "m_Id")
                    rows.append(
                        {
                            "id": kid,
                            "key": key_map.get(int(kid)) if kid is not None else None,
                            "value": _py_attr(e, "m_Localized") or "",
                        }
                    )
                if not rows:
                    continue
                sub = loc_dir / (locale or "unknown")
                write_json(sub / f"{name}.json", rows)
                n += 1
            except Exception:
                continue
    console.print(f"[green]localization[/] {n} 张 StringTable → {loc_dir}")
    return n


def export_text_configs(assets: Path) -> int:
    """没序列化的 TextAsset（json/txt/bytes 明文）格式化进 MasterData/config"""
    cfg_dir = MASTER_DIR / "config"
    n = 0
    needles = ("master", "config", "datatable", "setting", "scenario")
    for bp in assets.glob("*.bundle"):
        low = bp.name.lower()
        if not any(s in low for s in needles):
            continue
        try:
            env = UnityPy.load(str(bp))
        except Exception:
            continue
        for obj in env.objects:
            if obj.type.name != "TextAsset":
                continue
            try:
                data = obj.read()
                raw = getattr(data, "m_Script", None)
                if raw is None:
                    continue
                if isinstance(raw, str):
                    blob = raw.encode("utf-8")
                    text = raw
                else:
                    blob = bytes(raw)
                    text = blob.decode("utf-8")
                name = getattr(data, "name", None) or f"text_{obj.path_id}"
                dest = cfg_dir / f"{name}.json" if text.lstrip()[:1] in "{[" else cfg_dir / f"{name}.txt"
                dest.parent.mkdir(parents=True, exist_ok=True)
                if dest.suffix == ".json":
                    write_json(dest, json.loads(text))
                else:
                    dest.write_text(text, encoding="utf-8")
                n += 1
            except Exception:
                continue
    if n:
        console.print(f"[green]config TextAsset[/] {n} → {cfg_dir}")
    return n


def cmd_tables(args: argparse.Namespace) -> int:
    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    n = export_tables_from_api(args.app_ver)
    if ASSETS_DIR.exists():
        export_string_tables(ASSETS_DIR)
        export_text_configs(ASSETS_DIR)
    return 0 if n else 1


def cmd_update(args: argparse.Namespace) -> int:
    rc = cmd_assets(args)
    rc2 = cmd_tables(args)
    return rc or rc2


def cmd_status(_args: argparse.Namespace) -> int:
    bundles = list(ASSETS_DIR.glob("*.bundle")) if ASSETS_DIR.exists() else []
    unity = sum(1 for p in bundles if looks_unityfs(p.read_bytes()[:8]))
    tables = list(MASTER_DIR.glob("*.json")) if MASTER_DIR.exists() else []
    console.print(f"Assets  bundle={len(bundles)} unityfs={unity}  dir={ASSETS_DIR}")
    console.print(f"MasterData json={len(tables)}  dir={MASTER_DIR}")
    if (ASSETS_DIR / "catalog.json").exists():
        console.print(f"catalog {(ASSETS_DIR / 'catalog.json').stat().st_size}B")
    return 0



def main() -> int:
    parser = argparse.ArgumentParser(description="OverRush β 资产还原 / MasterData 导出")
    sub = parser.add_subparsers(dest="command")

    def _asset_args(p: argparse.ArgumentParser) -> None:
        p.add_argument("--apk", default="", help="apk/apks 路径，默认目录下最新")
        p.add_argument("--env", default="real", choices=sorted(ENVS), help="AppURLConfig 环境")
        p.add_argument("--cdn", default="", help="覆盖 CDN，默认跟 --env")
        p.add_argument("--dest", default="", help="输出目录，默认 Assets 或 Assets_<env>")
        p.add_argument("--catalog-rel", dest="catalog_rel", default="", help="覆盖 catalog 相对路径")
        p.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
        p.add_argument("--refresh-catalog", action="store_true")

    p_as = sub.add_parser("assets", help="APK+CDN 整合到 Assets/，按 catalog 解密")
    _asset_args(p_as)

    p_tb = sub.add_parser("tables", help="getInit protobuf → MasterData/*.json")
    p_tb.add_argument("--app-ver", dest="app_ver", default=APP_VER)

    p_up = sub.add_parser("update", help="assets + tables")
    _asset_args(p_up)
    p_up.add_argument("--app-ver", dest="app_ver", default=APP_VER)

    sub.add_parser("status", help="目录统计")

    args = parser.parse_args()
    if not args.command:
        args = parser.parse_args(["update"])
    if getattr(args, "env", None):
        apply_env(args.env, getattr(args, "dest", ""), getattr(args, "catalog_rel", ""))
        if getattr(args, "cdn", ""):
            global CDN_BASE
            CDN_BASE = args.cdn
        else:
            args.cdn = CDN_BASE
        console.print(f"env={args.env} cdn={CDN_BASE} catalog={CATALOG_REL} dest={ASSETS_DIR}")
    if getattr(args, "apk", "") == "":
        apk = default_apk()
        args.apk = str(apk) if apk else ""
    return {
        "assets": cmd_assets,
        "tables": cmd_tables,
        "update": cmd_update,
        "status": cmd_status,
    }[args.command](args)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/yellow]")
        raise SystemExit(130)
