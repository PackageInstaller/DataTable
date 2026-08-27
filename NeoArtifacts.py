from __future__ import annotations

import argparse
import gzip
import hashlib
import json
import mmap
import re
import shutil
import struct
import threading
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Iterable
from urllib.parse import urlparse

import requests
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
from requests.exceptions import HTTPError, SSLError
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)
from rich.table import Table

try:
    import lz4.block as lz4_block
except ImportError:
    lz4_block = None

GAME = "物华弥新"
PKG = "com.cipaishe.wuhua.bilibili"
PLATFORM = "Android"
LANG = "CN"
CLIENT_VERSION = "3.2.0"
UNITY_VERSION = "2018.4.36f1"
PACKET_FILE = "packet_config"
FIX_CONFIG = "fix_config"

TMPL_VERSIONS = "{cdn}/AssetVersions/{plat}/{lang}/{resver}/"
TMPL_VERSIONS_FILE = "{cdn}/AssetVersions/{plat}/{lang}/{resver}/{name}"
TMPL_FIXS = "{cdn}/AssetFixs/{plat}/{client}/{fixver}/"
TMPL_FIX_CONFIG = "{cdn}/AssetFixs/{plat}/{client}/{fixver}/fix_config"
TMPL_LANG = "{origin}/langdata_v3/{ver}/{lang}"
TMPL_CFC = "{origin}/cfc_v2/{md5}"

PATCH_ORIGINS = (
    "https://l4-prod-patch-lgmx.bilibiligame.net",
    "https://l1-prod-patch-lgmx.bilibiligame.net",
    "https://l3-prod-patch-lgmx.bilibiligame.net",
)
PATCH_HOSTS = tuple(f"{o}/resource" for o in PATCH_ORIGINS)
GATEWAYS = (
    "https://le4-prod-all-gateway-lgmx.bilibiligame.net/",
    "https://le3-prod-all-gateway-lgmx.bilibiligame.net/",
    "https://le1-prod-all-gateway-lgmx.bilibiligame.net/",
)

HTTP_HEADERS = {
    "User-Agent": f"UnityPlayer/{UNITY_VERSION} (UnityWebRequest/1.0, libcurl/7.84.0-DEV)",
    "Accept": "*/*",
    "X-Unity-Version": UNITY_VERSION,
}
LAUNCH_HEADERS = {
    "Content-Type": "application/json",
    "service": "net-config",
    "KeyVersion": CLIENT_VERSION,
    "IsEmulator": "False",
    "User-Agent": "BestHTTP/2 v2.8.5",
    "Accept-Encoding": "gzip, identity",
}

# CryptoTool.cctor → RuntimeHelpers.InitializeArray FieldRVA
# static+0x00 aesKey       B328E5EFE77DD39701CD8B3F4F83EA7628794833
# static+0x08 aesKeyTW     06BDD23700A04F7A1ED2BA83C2BFECF8C7CBA6CE
# static+0x10 serverAesKey A2B66443D6995270178434D1CD3AB1DC600969B8
# static+0x20 xorHeader    16DF53EA5F1339186DD08D4CD8DD543E32CE6E64
AES_KEY = bytes.fromhex("202011092152e1d5d3dab5eedcdf02de")
AES_KEY_TW = bytes.fromhex("202401111620e5d5d3dab7efddfb02ee")
SERVER_AES_KEY = bytes.fromhex("45ba18f59c0582de9f4dd96cbf3334ed")
XOR_HEADER = bytes.fromhex("556e69747946530000000006352e782e7800323031382e342e33366631")
XOR_RANGE = 73
BLOCKS_INFO_AT_THE_END = 0x80
COMPRESSION_TYPE_MASK = 0x3F
COMPRESSION_LZ4 = 2
COMPRESSION_LZ4HC = 3
XOR_MIN_LEN = 0x33
XOR_OBJ_START = 0x52
XOR_IDX_LAST_GT = 0x79
RETRY_COUNT = 4
CHUNK_SIZE = 1 << 20
PROBE_AHEAD = 40

IFIX_CODE = (
    "Ldind_U4", "Stelem_I1", "Newobj", "Conv_I8", "Ldc_I8", "Newanon", "Ldelem_Any",
    "Bge_Un", "Shl", "Endfinally", "Div", "Or", "Ldloca", "Mul_Ovf", "Conv_Ovf_I8_Un",
    "Callvirt", "Break", "Ldobj", "Shr", "Bgt_Un", "Conv_U2", "Conv_R4", "Refanyval",
    "Mkrefany", "Ldstr", "Ldind_I4", "Dup", "Conv_U1", "Starg", "Mul", "Ldc_R4", "Cpobj",
    "Stloc", "Conv_Ovf_U1", "Rethrow", "Br", "Stobj", "StackSpace", "Unbox", "Conv_Ovf_I1",
    "Isinst", "Endfilter", "Blt_Un", "Brfalse", "Conv_Ovf_U8", "Conv_Ovf_U4", "Clt", "Ble",
    "Ldelem_U2", "Conv_Ovf_U8_Un", "Ldind_I", "Pop", "Xor", "Ldvirtftn", "Volatile",
    "Ldelema", "Box", "Callvirtvirt", "Ret", "Shr_Un", "Ldtype", "Stelem_I", "Ldc_R8", "Not",
    "Castclass", "Brtrue", "Conv_I4", "Conv_U", "Conv_Ovf_I8", "Stind_I", "Conv_I1",
    "Ldelem_R8", "Stfld", "Unbox_Any", "Ldelem_R4", "Sub", "Unaligned", "Ldftn",
    "Conv_Ovf_U2_Un", "Call", "Constrained", "Stelem_R8", "Conv_Ovf_I_Un", "Stind_I8",
    "Conv_I2", "Ldelem_I4", "Stelem_I8", "Cpblk", "Beq", "Bne_Un", "Ldind_I1", "Ldfld",
    "Ldsflda", "Add_Ovf_Un", "Ldind_I8", "Stind_R8", "Stind_I2", "Rem", "Initobj",
    "Sub_Ovf_Un", "Stsfld", "Stelem_I4", "Ldelem_U1", "Rem_Un", "Cgt", "Sizeof", "Stind_Ref",
    "Add_Ovf", "Ldnull", "Ldc_I4", "Conv_R8", "Ldind_U1", "Ckfinite", "Add", "Refanytype",
    "Conv_Ovf_I", "Throw", "Ble_Un", "Nop", "Ldind_Ref", "Blt", "Ldind_I2", "Ldvirtftn2",
    "Conv_Ovf_U1_Un", "Stelem_I2", "Arglist", "Conv_U8", "Conv_Ovf_I2_Un", "Ldind_U2",
    "Conv_Ovf_I2", "Conv_Ovf_U_Un", "Conv_Ovf_I4_Un", "Clt_Un", "Mul_Ovf_Un", "Ldflda",
    "Ldelem_I1", "Newarr", "Bge", "Ceq", "Ldelem_U4", "Localloc", "CallExtern", "Conv_Ovf_I4",
    "Readonly", "Jmp", "Stind_R4", "Stind_I1", "Conv_R_Un", "Neg", "Ldlen", "Sub_Ovf",
    "Ldind_R4", "Stind_I4", "And", "Stelem_R4", "Ldsfld", "Tail", "Initblk", "Ldelem_Ref",
    "Ldind_R8", "Conv_I", "Switch", "Conv_Ovf_U", "Ldarg", "Cgt_Un", "Stelem_Ref",
    "Ldelem_I2", "Conv_Ovf_U4_Un", "No", "Conv_U4", "Bgt", "Ldloc", "Conv_Ovf_I1_Un",
    "Div_Un", "Conv_Ovf_U2", "Ldarga", "Leave", "Ldtoken", "Ldelem_I8", "Stelem_Any",
    "Ldelem_I",
)
IFIX_EH = {0: "Catch", 1: "Filter", 2: "Finally", 4: "Fault"}
# GetMethods(DeclaredOnly|Public|Instance) 按 metadata token 序
IFIX_IFACE_METHODS = {
    "System.IDisposable": ("Dispose",),
    "System.Collections.IEnumerator": ("MoveNext", "get_Current", "Reset"),
    "System.Collections.Generic.IEnumerator`1": ("get_Current",),
    "System.Runtime.CompilerServices.IAsyncStateMachine": ("MoveNext", "SetStateMachine"),
    "System.Runtime.CompilerServices.INotifyCompletion": ("OnCompleted",),
    "System.Runtime.CompilerServices.ICriticalNotifyCompletion": ("UnsafeOnCompleted",),
    "System.Collections.IEnumerable": ("GetEnumerator",),
    "System.Collections.Generic.IEnumerable`1": ("GetEnumerator",),
}

console = Console()
ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
BUNDLES_DIR = ASSETS_DIR / "bundles"
PACKETS_DIR = ASSETS_DIR / "packets"
MASTER_DIR = ROOT / "MasterData"
CFC_DIR = MASTER_DIR / "cfc"
JSON_DIR = MASTER_DIR / "json"
RESOLVED_DIR = MASTER_DIR / "resolved"
LANG_DIR = MASTER_DIR / "lang"
FIX_DIR = ROOT / "Fix"
FIXS_DIR = ASSETS_DIR / "fixs"
STATE_PATH = ROOT / "version.json"
DATA_DAT = ASSETS_DIR / "data.dat"
PAINTING_DIR = ROOT / "Painting"
PAINTING_PREFIX = "来古弥新"
DRAWING_PATH_RE = re.compile(
    r"^assets/_bundleresources/character/([^/]+)/drawing/([^/]+)\.png$",
    re.IGNORECASE,
)
_UNSAFE_FS = re.compile(r'[\\/:*?"<>|\x00-\x1f]')
_tls = threading.local()


def format_size(n: int) -> str:
    size = float(n)
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if size < 1024 or unit == "TB":
            return f"{size:.2f} {unit}"
        size /= 1024
    return f"{n} B"


def md5_file(path: Path, chunk_size: int = CHUNK_SIZE) -> str:
    h = hashlib.md5()
    with path.open("rb") as fh:
        while True:
            block = fh.read(chunk_size)
            if not block:
                break
            h.update(block)
    return h.hexdigest()


def md5_bytes(data: bytes) -> str:
    return hashlib.md5(data).hexdigest()


def crypto_record() -> dict[str, Any]:
    """写入 version.json，避免密钥只停在常量里。"""
    return {
        "aesKey": AES_KEY.hex(),
        "aesKeyTW": AES_KEY_TW.hex(),
        "serverAesKey": SERVER_AES_KEY.hex(),
        "xorHeader": XOR_HEADER.hex(),
        "xorHeaderNote": "UnityFS 29B / 2018.4.36f1",
        "xorTarget": "UnityFS blocks info start, 73 bytes (may spill into first data block)",
        "xorRange": XOR_RANGE,
        "xorKey": "ciphertext[offset+1]",
        "blocksInfoAtEnd": hex(BLOCKS_INFO_AT_THE_END),
    }


def is_xor_header(data: bytes) -> bool:
    return len(data) >= len(XOR_HEADER) and data.startswith(XOR_HEADER)


def bundle_key(name: str) -> int:
    raw = name.encode("utf-8")
    if len(raw) < 2:
        raise ValueError(f"BundleKey 需要至少 2 字节: {name!r}")
    return raw[1]


def longyuan_xo(buf: bytearray, key: int) -> None:
    """还原上次误用的整文件 [50,122] 异或。"""
    n = len(buf)
    if n < XOR_MIN_LEN:
        return
    i = XOR_OBJ_START
    while True:
        idx = i - 32
        if idx >= n:
            break
        buf[idx] ^= key
        if idx > XOR_IDX_LAST_GT:
            break
        if i - 31 >= n:
            break
        i += 1


def parse_unityfs_header(data: bytes) -> dict[str, int] | None:
    if not data.startswith(b"UnityFS\x00") or len(data) < 50:
        return None
    pos = 8
    version = struct.unpack_from(">I", data, pos)[0]
    pos += 4

    def read_cstr(p: int) -> tuple[str, int]:
        z = data.index(b"\x00", p)
        return data[p:z].decode("ascii", "replace"), z + 1

    try:
        _pv, pos = read_cstr(pos)
        unity_revision, pos = read_cstr(pos)
    except ValueError:
        return None
    if pos + 20 > len(data):
        return None
    file_size, cinfo, uinfo, flags = struct.unpack_from(">qIII", data, pos)
    pos += 20
    if version >= 7 and pos % 16:
        pos += 16 - (pos % 16)
    elif unity_revision.startswith("2019.4") and pos % 16:
        pad = 16 - (pos % 16)
        if data[pos : pos + pad] == b"\x00" * pad:
            pos += pad
    if flags & BLOCKS_INFO_AT_THE_END:
        boff = file_size - cinfo
        data_off = pos
    else:
        boff = pos
        data_off = boff + cinfo
    if cinfo <= 0 or boff < 0 or boff + cinfo > len(data):
        return None
    return {
        "version": version,
        "cinfo": cinfo,
        "uinfo": uinfo,
        "flags": flags,
        "boff": boff,
        "data_off": data_off,
        "comp": flags & COMPRESSION_TYPE_MASK,
    }


def xor_blocks_info(data: bytes) -> bytes | None:
    """从 blocks info 起点异或 73 字节，密钥为该段第 2 字节。

    与 LongYuanSDK.XO 的 [50,122] 对齐。cinfo<73 时会写进后面的 data block，
    不能裁成 blocks info 长度。
    """
    info = parse_unityfs_header(data)
    if info is None:
        return None
    if info["comp"] not in (COMPRESSION_LZ4, COMPRESSION_LZ4HC):
        return None
    off = info["boff"]
    if off + 2 > len(data):
        return None
    out = bytearray(data)
    key = out[off + 1]
    limit = min(XOR_RANGE, len(out) - off)
    if limit <= 1:
        return None
    for i in range(limit):
        out[off + i] ^= key
    return bytes(out)


def _lz4_unpack(blob: bytes, usize: int) -> bytes | None:
    if lz4_block is None or usize <= 0:
        return None
    try:
        out = lz4_block.decompress(blob, uncompressed_size=usize)
    except Exception:
        return None
    return out if len(out) == usize else None


def unityfs_blocks_ok(data: bytes) -> bool:
    """blocks info 能 LZ4，且第一个 data block 也能解开（避免 cinfo<73 漏解密）。"""
    info = parse_unityfs_header(data)
    if info is None:
        return False
    if info["comp"] not in (COMPRESSION_LZ4, COMPRESSION_LZ4HC):
        return True
    u = _lz4_unpack(data[info["boff"] : info["boff"] + info["cinfo"]], info["uinfo"])
    if u is None or len(u) < 30:
        return False
    nblocks = struct.unpack_from(">I", u, 16)[0]
    if nblocks < 1 or 20 + 10 > len(u):
        return False
    usize, csize, bflags = struct.unpack_from(">IIH", u, 20)
    blob = data[info["data_off"] : info["data_off"] + csize]
    if len(blob) != csize:
        return False
    ct = bflags & COMPRESSION_TYPE_MASK
    if ct in (COMPRESSION_LZ4, COMPRESSION_LZ4HC):
        return _lz4_unpack(blob, usize) is not None
    return ct == 0


def decrypt_unityfs_ab(data: bytes, name: str = "") -> tuple[bytes, str]:
    """CDN / 误解密 AB → 明文。"""
    if parse_unityfs_header(data) is None:
        return data, "plain"
    if unityfs_blocks_ok(data):
        return data, "skipped"
    trial = xor_blocks_info(data)
    if trial is not None and unityfs_blocks_ok(trial):
        return trial, "decrypted"
    names = [name] if name else []
    for nm in names:
        restored = bytearray(data)
        try:
            longyuan_xo(restored, bundle_key(nm))
        except ValueError:
            continue
        restored_b = bytes(restored)
        if unityfs_blocks_ok(restored_b):
            return restored_b, "skipped"
        trial = xor_blocks_info(restored_b)
        if trial is not None and unityfs_blocks_ok(trial):
            return trial, "decrypted"
    return data, "fail"


def xor_decrypt_ab(data: bytes, name: str) -> bytes:
    out, _st = decrypt_unityfs_ab(data, name)
    return out


def xor_decrypt_file(path: Path, name: str, expect_md5: str = "") -> str:
    data = path.read_bytes()
    out, status = decrypt_unityfs_ab(data, name or path.name)
    if status == "decrypted" and out != data:
        path.write_bytes(out)
    _ = expect_md5
    return status


def aes_ecb_decrypt(data: bytes, key: bytes) -> bytes:
    if len(data) % 16:
        raise ValueError(f"AES 长度不是 16 的倍数: {len(data)}")
    return unpad(AES.new(key, AES.MODE_ECB).decrypt(data), 16)


def aes_ecb_encrypt(data: bytes, key: bytes) -> bytes:
    return AES.new(key, AES.MODE_ECB).encrypt(pad(data, 16))


def decrypt_cfc_payload(payload: bytes) -> bytes:
    return gzip.decompress(aes_ecb_decrypt(payload, AES_KEY))


def extra_from_launch(data: dict[str, Any]) -> dict[str, Any]:
    """把 get_launch_data_v2 的 data 映到脚本用的字段。"""
    extra: dict[str, Any] = {}
    if data.get("VersionURL"):
        extra["cdn"] = data["VersionURL"].rstrip("/")
    if data.get("SmallPackVersion"):
        extra["resVersion"] = data["SmallPackVersion"]
    extra["launchResVersion"] = data.get("ResVersion")
    if data.get("ConfigVersion_v2"):
        extra["cfcVersion"] = data["ConfigVersion_v2"]
    if data.get("ConfigURL_v2"):
        extra["cfcUrl"] = data["ConfigURL_v2"]
    if data.get("LangData") is not None:
        extra["langVersion"] = data["LangData"]
    extra["lang"] = (data.get("Localization") or LANG).lower()
    lang_base = (data.get("LangDataURL_v3") or "").rstrip("/")
    if lang_base:
        extra["langUrl"] = f"{lang_base}/{extra['lang']}"
    if data.get("LangMD5"):
        extra["langMd5"] = data["LangMD5"]
    if data.get("FixVersion"):
        extra["fixVersion"] = data["FixVersion"]
    if data.get("ClientVersion"):
        extra["clientVersion"] = data["ClientVersion"]
    extra["launch"] = data
    return extra


def fetch_launch_data() -> dict[str, Any]:
    payload = json.dumps(
        {
            "Platform": PLATFORM,
            "Channel": "onesdk",
            "ClientVersion": CLIENT_VERSION,
            "ResVersion": "r1",
            "FixVersion": "",
            "ServerId": "prod",
        },
        separators=(",", ":"),
    ).encode("utf-8")
    body = aes_ecb_encrypt(payload, SERVER_AES_KEY)
    last_err: Exception | None = None
    for gw in GATEWAYS:
        url = gw.rstrip("/") + "/get_launch_data_v2"
        try:
            resp = get_session().post(url, data=body, headers=LAUNCH_HEADERS, timeout=20)
            resp.raise_for_status()
            pt = aes_ecb_decrypt(resp.content, SERVER_AES_KEY)
            doc = json.loads(pt.decode("utf-8"))
            if doc.get("errinfo"):
                raise RuntimeError(doc["errinfo"])
            data = doc.get("data") or {}
            if not data:
                raise RuntimeError("launch data 为空")
            return data
        except Exception as exc:  # noqa: BLE001
            last_err = exc
            continue
    raise RuntimeError(str(last_err) if last_err else "launch 失败")


def get_session() -> requests.Session:
    session = getattr(_tls, "session", None)
    if session is None:
        session = requests.Session()
        session.headers.update(HTTP_HEADERS)
        _tls.session = session
    return session


def http_get(
    url: str,
    timeout: int = 60,
    stream: bool = False,
    headers: dict[str, str] | None = None,
) -> requests.Response:
    resp = get_session().get(url, timeout=timeout, stream=stream, headers=headers)
    resp.raise_for_status()
    return resp


def load_state() -> dict[str, Any]:
    if STATE_PATH.exists():
        return json.loads(STATE_PATH.read_text(encoding="utf-8"))
    return {}


def save_state(state: dict[str, Any]) -> None:
    prev = load_state()
    prev.update(state)
    prev.update(crypto_record())
    for stale in ("xorIndex", "bundleKey", "xorIndexInclusive"):
        prev.pop(stale, None)
    STATE_PATH.write_text(
        json.dumps(prev, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )


def find_apk() -> Path | None:
    apks = sorted(ROOT.glob("*.apk"), key=lambda p: p.stat().st_mtime, reverse=True)
    return apks[0] if apks else None


def parse_res_number(ver: str) -> int | None:
    m = re.search(r"(\d+)$", ver or "")
    return int(m.group(1)) if m else None


def load_apk_config(apk: Path | None = None) -> dict[str, Any]:
    apk = apk or find_apk()
    if apk is None:
        return {}
    with zipfile.ZipFile(apk) as zf:
        raw = zf.read("assets/config")
    return json.loads(raw.decode("utf-8"))


def find_har() -> Path | None:
    hars = sorted(ROOT.glob("*.har"), key=lambda p: p.stat().st_mtime, reverse=True)
    return hars[0] if hars else None


def parse_har(path: Path) -> dict[str, Any]:
    """从抓包还原 CDN / sXXXX / fix / cfc / lang。"""
    har = json.loads(path.read_text(encoding="utf-8", errors="replace"))
    out: dict[str, Any] = {"har": path.name}
    for entry in har.get("log", {}).get("entries", []):
        url = entry.get("request", {}).get("url", "")
        if "/AssetVersions/" in url and url.rstrip("/").endswith(PACKET_FILE):
            parts = urlparse(url).path.strip("/").split("/")
            # resource/AssetVersions/Android/CN/s2856/packet_config
            try:
                i = parts.index("AssetVersions")
                out["cdn"] = url[: url.index("/AssetVersions")]
                out["platform"] = parts[i + 1]
                out["lang"] = parts[i + 2]
                out["resVersion"] = parts[i + 3]
            except (ValueError, IndexError):
                pass
        elif "/AssetFixs/" in url and url.rstrip("/").endswith(FIX_CONFIG):
            parts = urlparse(url).path.strip("/").split("/")
            try:
                i = parts.index("AssetFixs")
                out.setdefault("cdn", url[: url.index("/AssetFixs")])
                out["clientVersion"] = parts[i + 2]
                out["fixVersion"] = parts[i + 3]
            except (ValueError, IndexError):
                pass
        elif "/cfc_v2/" in url:
            out["cfcVersion"] = url.rstrip("/").rsplit("/", 1)[-1]
            out["cfcUrl"] = url
            origin = url[: url.index("/cfc_v2")]
            out.setdefault("cdn", origin.rstrip("/") + "/resource")
        elif "/langdata_v3/" in url:
            parts = urlparse(url).path.strip("/").split("/")
            try:
                i = parts.index("langdata_v3")
                out["langVersion"] = int(parts[i + 1])
                out["lang"] = parts[i + 2]
            except (ValueError, IndexError, TypeError):
                pass
            out["langUrl"] = url
            origin = url[: url.index("/langdata_v3")]
            out.setdefault("cdn", origin.rstrip("/") + "/resource")
    return out


def cdn_origin(cdn: str) -> str:
    return cdn.rstrip("/").removesuffix("/resource")


def pick_cdn(preferred: str | None = None) -> list[str]:
    hosts = list(PATCH_HOSTS)
    if preferred:
        preferred = preferred.rstrip("/")
        if not preferred.endswith("/resource"):
            preferred = preferred + "/resource"
        if preferred in hosts:
            hosts.remove(preferred)
        hosts.insert(0, preferred)
    return hosts


def failover_urls(url: str, cdn: str, cdns: list[str]) -> list[str]:
    urls = [url]
    origin = cdn_origin(cdn)
    for other in cdns:
        if other == cdn:
            continue
        alt = url.replace(cdn, other, 1)
        if alt == url:
            alt = url.replace(origin, cdn_origin(other), 1)
        if alt not in urls:
            urls.append(alt)
    return urls


def url_packet_config(cdn: str, resver: str, plat: str = PLATFORM, lang: str = LANG) -> str:
    return TMPL_VERSIONS_FILE.format(
        cdn=cdn.rstrip("/"), plat=plat, lang=lang, resver=resver, name=PACKET_FILE
    )


def url_packet(cdn: str, resver: str, name: str, plat: str = PLATFORM, lang: str = LANG) -> str:
    return TMPL_VERSIONS_FILE.format(
        cdn=cdn.rstrip("/"), plat=plat, lang=lang, resver=resver, name=name
    )


def url_fix_config(cdn: str, fixver: str, client: str = CLIENT_VERSION, plat: str = PLATFORM) -> str:
    return TMPL_FIX_CONFIG.format(
        cdn=cdn.rstrip("/"), plat=plat, client=client, fixver=fixver
    )


def url_fix_file(
    cdn: str, fixver: str, name: str, client: str = CLIENT_VERSION, plat: str = PLATFORM
) -> str:
    return TMPL_FIXS.format(
        cdn=cdn.rstrip("/"), plat=plat, client=client, fixver=fixver
    ) + name


def normalize_packet_doc(data: Any) -> dict[str, Any] | None:
    if not isinstance(data, dict):
        return None
    if isinstance(data.get("list"), list) and data["list"]:
        return data
    if "fileList" in data and "version" in data:
        return {"list": [data]}
    return None


def probe_packet_config(cdns: Iterable[str], resver: str) -> tuple[str, dict[str, Any]] | None:
    """404 / 非 JSON 视为该版本不存在；连接错误静默换下一个 CDN。"""
    for cdn in cdns:
        url = url_packet_config(cdn, resver)
        try:
            resp = get_session().get(url, timeout=15)
            if resp.status_code != 200:
                continue
            text = resp.content.lstrip()
            if not text.startswith(b"{") and not text.startswith(b"["):
                continue
            doc = normalize_packet_doc(resp.json())
            if doc:
                return cdn.rstrip("/"), doc
        except Exception:  # noqa: BLE001
            continue
    return None


def discover_res_version(
    cdns: list[str],
    base_ver: str | None,
    explicit: str | None,
    probe: bool,
) -> tuple[str, str, dict[str, Any]]:
    """返回 (cdn, resVersion, packet_config json)。"""
    if explicit:
        found = probe_packet_config(cdns, explicit)
        if not found:
            raise RuntimeError(f"指定版本 {explicit} 的 packet_config 不存在")
        return found[0], explicit, found[1]

    start_n = parse_res_number(base_ver or "") or 0
    candidates: list[str] = []
    if base_ver and str(base_ver).startswith("s"):
        candidates.append(str(base_ver))
    if start_n:
        if f"s{start_n}" not in candidates:
            candidates.append(f"s{start_n}")
        if probe:
            for n in range(start_n + 1, start_n + PROBE_AHEAD + 1):
                candidates.append(f"s{n}")

    best: tuple[str, str, dict[str, Any]] | None = None
    misses = 0
    for ver in candidates:
        found = probe_packet_config(cdns, ver)
        if found:
            best = (found[0], ver, found[1])
            misses = 0
            console.print(f"[green]packet_config[/] {ver}  @ {found[0]}")
            if not probe:
                break
        else:
            misses += 1
            if probe and best and misses >= 3:
                break
    if best is None:
        raise RuntimeError("没有探测到可用的 sXXXX/packet_config（检查网络或传入 --res-version）")
    return best


def current_packet_config(doc: dict[str, Any], resver: str) -> dict[str, Any]:
    rows = list(doc.get("list") or [])
    for row in rows:
        if row.get("version") == resver:
            return row
    if len(rows) == 1:
        return rows[0]
    raise RuntimeError(f"packet_config 里没有 version={resver}")


def iter_packet_files(config: dict[str, Any]) -> list[dict[str, Any]]:
    return list(config.get("fileList") or [])


def download_file(
    urls: list[str],
    dest: Path,
    expected_md5: str = "",
    expected_size: int = 0,
    retries: int = RETRY_COUNT,
    force: bool = False,
) -> str:
    dest.parent.mkdir(parents=True, exist_ok=True)
    expect_md5 = (expected_md5 or "").lower()

    def dest_ok() -> bool:
        if not dest.exists():
            return False
        cur = dest.stat().st_size
        if expected_size and cur != expected_size:
            return False
        if expect_md5 and md5_file(dest) != expect_md5:
            return False
        if not expected_size and not expect_md5:
            return cur > 0
        return True

    if dest_ok() and not force:
        return "skip"

    last_err: Exception | None = None
    for url in urls:
        for _attempt in range(retries):
            try:
                headers: dict[str, str] = {}
                mode = "wb"
                initial = 0
                if dest.exists():
                    if dest_ok() and not force:
                        return "skip"
                    cur = dest.stat().st_size
                    if expected_size and cur > expected_size:
                        dest.unlink()
                    elif expected_size and 0 < cur < expected_size:
                        initial = cur
                        headers["Range"] = f"bytes={cur}-"
                        mode = "ab"
                    elif not expected_size:
                        dest.unlink()
                    else:
                        dest.unlink()
                r = get_session().get(url, headers=headers, stream=True, timeout=60)
                if r.status_code == 416:
                    if dest_ok():
                        return "skip"
                    dest.unlink(missing_ok=True)
                    last_err = HTTPError(f"416 {url}", response=r)
                    continue
                if r.status_code == 206:
                    mode = "ab"
                elif r.status_code == 200:
                    mode = "wb"
                    initial = 0
                elif r.status_code in (404, 403):
                    last_err = HTTPError(f"{r.status_code} {url}", response=r)
                    break
                else:
                    r.raise_for_status()
                with dest.open(mode) as fh:
                    if initial == 0:
                        fh.seek(0)
                        fh.truncate()
                    for chunk in r.iter_content(CHUNK_SIZE):
                        if chunk:
                            fh.write(chunk)
                if expected_size and dest.stat().st_size != expected_size:
                    raise ValueError(f"size {dest.stat().st_size} != {expected_size}")
                if expect_md5 and md5_file(dest) != expect_md5:
                    raise ValueError("md5 mismatch")
                return "ok"
            except SSLError as exc:
                last_err = exc
                break
            except HTTPError as exc:
                last_err = exc
                code = exc.response.status_code if exc.response is not None else 0
                if code in (404, 403):
                    break
            except Exception as exc:  # noqa: BLE001
                last_err = exc
                if dest.exists() and expected_size and dest.stat().st_size > expected_size:
                    dest.unlink(missing_ok=True)
    raise RuntimeError(str(last_err) if last_err else "download failed")


def ab_dest(ab: dict[str, Any]) -> Path:
    name = ab["name"]
    rel = (ab.get("path") or "").strip("/")
    if not rel:
        return ASSETS_DIR / name
    if rel == "bundles" or rel.startswith("bundles/"):
        return (ASSETS_DIR / rel) / name
    return (ASSETS_DIR / rel) / name


def packet_already_split(info: dict[str, Any]) -> bool:
    dic = info.get("dicAB") or {}
    if not dic:
        return False
    for ab in dic.values():
        dest = ab_dest(ab)
        if not dest.is_file():
            return False
        if dest.stat().st_size != int(ab["size"]):
            return False
    return True


def xor_decrypt_packet(info: dict[str, Any]) -> tuple[int, int]:
    """对已切片但仍是 CDN 密文的 AB 做 XOR。"""
    dec = skip = 0
    for ab in (info.get("dicAB") or {}).values():
        dest = ab_dest(ab)
        if not dest.is_file():
            continue
        st = xor_decrypt_file(dest, ab["name"], ab.get("md5") or "")
        if st == "decrypted":
            dec += 1
        else:
            skip += 1
    return dec, skip


def split_packet_file(packet_path: Path, info: dict[str, Any], keep_packet: bool) -> tuple[int, int]:
    """按 dicAB 切片，校验 CDN md5 后解密 UnityFS XOR。"""
    ok = fail = 0
    dic = info.get("dicAB") or {}
    size = packet_path.stat().st_size
    with packet_path.open("rb") as fh, mmap.mmap(fh.fileno(), 0, access=mmap.ACCESS_READ) as mm:
        for ab in dic.values():
            start = int(ab["start"])
            length = int(ab["size"])
            name = ab["name"]
            dest = ab_dest(ab)
            dest.parent.mkdir(parents=True, exist_ok=True)
            if start < 0 or length < 0 or start + length > size:
                console.print(f"[red]切片越界[/] {name} start={start} size={length} file={size}")
                fail += 1
                continue
            chunk = bytes(mm[start : start + length])
            expect = (ab.get("md5") or "").lower()
            if expect and md5_bytes(chunk) != expect:
                console.print(f"[red]切片 MD5 不符[/] {name}")
                fail += 1
                continue
            plain, _st = decrypt_unityfs_ab(chunk, name)
            dest.write_bytes(plain)
            ok += 1
    if not keep_packet:
        packet_path.unlink(missing_ok=True)
    return ok, fail


def parse_cfc(data: bytes) -> list[tuple[str, bytes]]:
    """cfc_v2 / assets/data_config：u32be 名长 + 名 + u32be 大小 + payload。"""
    items: list[tuple[str, bytes]] = []
    d = 0
    n = len(data)
    while d + 8 <= n:
        nl = int.from_bytes(data[d : d + 4], "big")
        d += 4
        if nl <= 0 or nl > 256 or d + nl + 4 > n:
            break
        name = data[d : d + nl].decode("utf-8")
        d += nl
        sz = int.from_bytes(data[d : d + 4], "big")
        d += 4
        if sz < 0 or d + sz > n:
            break
        items.append((name, data[d : d + sz]))
        d += sz
    return items


def export_cfc(data: bytes, lang: dict[str, str] | None = None) -> tuple[int, int]:
    """cfc_v2 字节流：切片 + AES + GZip + JSON + [a;b]/Lan 一次写成最终表。"""
    JSON_DIR.mkdir(parents=True, exist_ok=True)
    items = parse_cfc(data)
    json_ok = 0
    for name, payload in items:
        try:
            parsed = json.loads(decrypt_cfc_payload(payload).decode("utf-8"))
            parsed = try_deserialize_value(parsed)
            if lang:
                parsed = resolve_lang_fields(parsed, lang)
            (JSON_DIR / f"{name}.json").write_text(
                json.dumps(parsed, ensure_ascii=False, indent=2) + "\n",
                encoding="utf-8",
            )
            json_ok += 1
        except Exception as exc:  # noqa: BLE001
            console.print(f"[yellow]解密失败[/] {name}: {exc}")
    return len(items), json_ok


def lang_from_cipher(data: bytes) -> dict[str, str]:
    return parse_lang_decoded(gzip.decompress(aes_ecb_decrypt(data, AES_KEY)))


def decode_lang_file(path: Path) -> tuple[Path, dict[str, str]]:
    table = lang_from_cipher(path.read_bytes())
    dest = path.with_suffix(".json")
    dest.write_text(json.dumps(table, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return dest, table


class _Bin:
    """.NET BinaryReader on a bytes buffer (little-endian, 7-bit strings)."""

    def __init__(self, data: bytes):
        self.data = data
        self.p = 0

    def left(self) -> int:
        return len(self.data) - self.p

    def u8(self) -> int:
        x = self.data[self.p]
        self.p += 1
        return x

    def boolean(self) -> bool:
        return self.u8() != 0

    def i32(self) -> int:
        x = struct.unpack_from("<i", self.data, self.p)[0]
        self.p += 4
        return x

    def u64(self) -> int:
        x = struct.unpack_from("<Q", self.data, self.p)[0]
        self.p += 8
        return x

    def i7(self) -> int:
        n = 0
        shift = 0
        while True:
            b = self.u8()
            n |= (b & 0x7F) << shift
            if b < 0x80:
                return n
            shift += 7

    def string(self) -> str:
        n = self.i7()
        t = self.data[self.p : self.p + n]
        self.p += n
        return t.decode("utf-8")


def short_type(aqn: str) -> str:
    name = aqn.split(", Version=", 1)[0]
    name = name.replace(", Culture=neutral, PublicKeyToken=null", "")
    name = name.replace(", Culture=neutral, PublicKeyToken=b77a5c561934e089", "")
    return name


def _iface_key(aqn: str) -> str:
    name = aqn.split(", ", 1)[0]
    if "[[" in name:
        name = name.split("[[", 1)[0]
    return name


def parse_lang_decoded(data: bytes) -> dict[str, str]:
    """FileTool BE short/byte/int：keyCount × (keyLen+key) + contentLen + utf8。"""
    pos = 0
    n = len(data)
    out: dict[str, str] = {}
    while pos + 2 <= n:
        key_count = int.from_bytes(data[pos : pos + 2], "big", signed=True)
        pos += 2
        if key_count < 1:
            break
        keys: list[str] = []
        for _ in range(key_count):
            if pos >= n:
                break
            klen = data[pos]
            pos += 1
            if klen < 1:
                break
            keys.append(data[pos : pos + klen].decode("utf-8"))
            pos += klen
        clen = int.from_bytes(data[pos : pos + 4], "big", signed=True)
        pos += 4
        if clen < 0 or pos + clen > n:
            break
        content = data[pos : pos + clen].decode("utf-8")
        pos += clen
        for key in keys:
            out[key] = content
    return out


def _ifix_read_method(r: _Bin, types: list[str]) -> dict[str, Any]:
    is_generic = r.boolean()
    declaring = short_type(types[r.i32()])
    name = r.string()
    if is_generic:
        gargs = [short_type(types[r.i32()]) for _ in range(r.i32())]
        params: list[str] = []
        for _ in range(r.i32()):
            if r.boolean():
                params.append(r.string())
            else:
                params.append(short_type(types[r.i32()]))
        return {
            "generic": True,
            "declaringType": declaring,
            "name": name,
            "genericArgs": gargs,
            "params": params,
        }
    params = [short_type(types[r.i32()]) for _ in range(r.i32())]
    return {
        "generic": False,
        "declaringType": declaring,
        "name": name,
        "params": params,
    }


def _ifix_fmt_method(info: dict[str, Any]) -> str:
    args = ", ".join(info.get("params") or [])
    g = ""
    if info.get("generic") and info.get("genericArgs"):
        g = "<" + ", ".join(info["genericArgs"]) + ">"
    return f"{info['declaringType']}::{info['name']}{g}({args})"


def _ifix_decode_ins(
    code: int,
    operand: int,
    intern: list[str],
    extern_methods: list[dict[str, Any]],
    fields: list[dict[str, Any]],
    types: list[str],
) -> dict[str, Any]:
    op = IFIX_CODE[code] if 0 <= code < len(IFIX_CODE) else f"?{code}"
    rec: dict[str, Any] = {"op": op, "operand": operand}
    if op == "Ldstr" and 0 <= operand < len(intern):
        rec["str"] = intern[operand]
    elif op in ("CallExtern", "Call", "Callvirt", "Newobj", "Ldftn", "Ldvirtftn") and 0 <= operand < len(
        extern_methods
    ):
        rec["method"] = _ifix_fmt_method(extern_methods[operand])
    elif op in ("Ldfld", "Ldsfld", "Stfld", "Stsfld", "Ldflda", "Ldsflda") and 0 <= operand < len(
        fields
    ):
        f = fields[operand]
        rec["field"] = f"{f['declaringType']}.{f['name']}"
    elif op in ("Ldtype", "Newarr", "Box", "Castclass", "Isinst", "Unbox", "Unbox_Any", "Initobj"):
        if 0 <= operand < len(types):
            rec["type"] = short_type(types[operand])
    return rec


def parse_ifix_patch(data: bytes) -> dict[str, Any]:
    """Tencent InjectFix PatchManager.Load；opcode 用本包 IFix.Core.Code。"""
    r = _Bin(data)
    magic = r.u64()
    bridge = r.string()
    extern_type_count = r.i32()
    types = [r.string() for _ in range(extern_type_count)]
    method_count = r.i32()
    raw_methods: list[dict[str, Any]] = []
    for _ in range(method_count):
        code_size = r.i32()
        ins = [{"code": r.i32(), "operand": r.i32()} for _ in range(code_size)]
        eh_n = r.i32()
        ehs = []
        for _ in range(eh_n):
            ht, catch_id, ts, te, hs, he = (
                r.i32(),
                r.i32(),
                r.i32(),
                r.i32(),
                r.i32(),
                r.i32(),
            )
            ehs.append(
                {
                    "handlerType": IFIX_EH.get(ht, ht),
                    "catchTypeId": catch_id,
                    "tryStart": ts,
                    "tryEnd": te,
                    "handlerStart": hs,
                    "handlerEnd": he,
                }
            )
        raw_methods.append({"ins": ins, "eh": ehs})
    extern_methods = [_ifix_read_method(r, types) for _ in range(r.i32())]
    intern = [r.string() for _ in range(r.i32())]
    field_count = r.i32()
    fields: list[dict[str, Any]] = []
    for _ in range(field_count):
        is_new = r.boolean()
        rec = {
            "new": is_new,
            "declaringType": short_type(types[r.i32()]),
            "name": r.string(),
        }
        if is_new:
            rec["fieldType"] = short_type(types[r.i32()])
            rec["methodId"] = r.i32()
        fields.append(rec)
    statics = []
    for _ in range(r.i32()):
        statics.append({"type": short_type(types[r.i32()]), "cctor": r.i32()})
    storeys = []
    for _ in range(r.i32()):
        field_num = r.i32()
        field_types = [r.i32() for _ in range(field_num)]
        ctor_id = r.i32()
        ctor_param_num = r.i32()
        iface_count = r.i32()
        ifaces: list[dict[str, Any]] = []
        if iface_count:
            for _ in range(iface_count):
                itf_id = r.i32()
                aqn = types[itf_id]
                key = _iface_key(aqn)
                names = IFIX_IFACE_METHODS.get(key)
                if names is None:
                    raise ValueError(f"未知 IFix 接口，无法读 slot: {key}")
                ids = [r.i32() for _ in names]
                ifaces.append(
                    {
                        "type": short_type(aqn),
                        "methods": dict(zip(names, ids, strict=True)),
                    }
                )
        vmn = r.i32()
        vtable = [r.i32() for _ in range(vmn)]
        storeys.append(
            {
                "fieldNum": field_num,
                "fieldTypes": field_types,
                "ctorId": ctor_id,
                "ctorParamNum": ctor_param_num,
                "interfaces": ifaces,
                "vTable": vtable,
            }
        )
    wrappers = r.string()
    assembly = r.string()
    fixes = []
    for _ in range(r.i32()):
        info = _ifix_read_method(r, types)
        info["methodId"] = r.i32()
        info["signature"] = _ifix_fmt_method(info)
        fixes.append(info)
    new_classes: list[str] = []
    if r.left() >= 4:
        ncc = r.i32()
        new_classes = [r.string() for _ in range(ncc)]
    if r.left() != 0:
        raise ValueError(f"IFix 解析后仍剩 {r.left()} 字节")

    methods_out = []
    for i, raw in enumerate(raw_methods):
        methods_out.append(
            {
                "index": i,
                "exceptionHandlers": raw["eh"],
                "il": [
                    _ifix_decode_ins(
                        x["code"], x["operand"], intern, extern_methods, fields, types
                    )
                    for x in raw["ins"]
                ],
            }
        )
    for fix in fixes:
        mid = fix["methodId"]
        if 0 <= mid < len(methods_out):
            fix["il"] = methods_out[mid]["il"]
            fix["exceptionHandlers"] = methods_out[mid]["exceptionHandlers"]
    return {
        "magic": hex(magic),
        "interfaceBridge": short_type(bridge),
        "wrappersManager": short_type(wrappers),
        "assemblySuffix": assembly,
        "externTypeCount": len(types),
        "externTypes": [short_type(t) for t in types],
        "internStrings": intern,
        "fields": fields,
        "staticFieldTypes": statics,
        "anonymousStoreys": storeys,
        "externMethods": [_ifix_fmt_method(m) for m in extern_methods],
        "patchedMethods": fixes,
        "vmMethodCount": len(methods_out),
        "newClasses": new_classes,
    }


def export_ifix(path: Path) -> Path:
    doc = parse_ifix_patch(path.read_bytes())
    dest = path.with_name(path.stem + ".json")
    dest.write_text(json.dumps(doc, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return dest


_BRACKET_RE = re.compile(r"^\[([^\[\]{}]*)\]$")
_INT_RE = re.compile(r"^-?\d+$")
_FLOAT_RE = re.compile(r"^-?\d+\.\d+$")


def try_deserialize_value(value: Any) -> Any:
    """能当 JSON / [a;b;c] 解的字符串都解开。"""
    if isinstance(value, dict):
        return {k: try_deserialize_value(v) for k, v in value.items()}
    if isinstance(value, list):
        return [try_deserialize_value(v) for v in value]
    if not isinstance(value, str):
        return value
    text = value.strip()
    if not text:
        return value
    if (text.startswith("{") and text.endswith("}")) or (
        text.startswith("[") and ('"' in text or text.startswith("[{") or text.startswith("[["))
    ):
        try:
            return try_deserialize_value(json.loads(text))
        except json.JSONDecodeError:
            pass
    m = _BRACKET_RE.fullmatch(text)
    if m:
        inner = m.group(1)
        if not inner:
            return []
        parts = [p.strip() for p in inner.split(";")]
        out: list[Any] = []
        for part in parts:
            if _INT_RE.fullmatch(part):
                out.append(int(part))
            elif _FLOAT_RE.fullmatch(part):
                out.append(float(part))
            else:
                out.append(part)
        return out
    return value


def resolve_lang_fields(value: Any, lang: dict[str, str]) -> Any:
    """保留原键，*Lan 字段旁加 *Text。"""
    if isinstance(value, dict):
        out: dict[str, Any] = {}
        for key, val in value.items():
            out[key] = resolve_lang_fields(val, lang)
            if isinstance(val, str) and val and val in lang:
                out[f"{key}Text"] = lang[val]
        return out
    if isinstance(value, list):
        return [resolve_lang_fields(v, lang) for v in value]
    return value


def clean_intermediates() -> None:
    """清掉解密过程里落盘的明文/分片，只留密文缓存和最终 JSON。"""
    for path in LANG_DIR.glob("*.decoded"):
        path.unlink(missing_ok=True)
    if CFC_DIR.exists():
        shutil.rmtree(CFC_DIR)
    if RESOLVED_DIR.exists():
        shutil.rmtree(RESOLVED_DIR)
    if FIXS_DIR.exists():
        for path in FIXS_DIR.glob("*.patched.json"):
            path.unlink(missing_ok=True)
    if any(FIXS_DIR.glob("*.bytes")):
        (FIX_DIR / "fix_0").unlink(missing_ok=True)
    if PACKETS_DIR.exists() and not any(PACKETS_DIR.iterdir()):
        PACKETS_DIR.rmdir()


def md5_ab_filename(logical: str) -> str:
    """AssetManager.Md5Name：取最后一段，去掉扩展名，MD5 + .ab。"""
    base = logical.replace("\\", "/").rsplit("/", 1)[-1]
    dot = base.rfind(".")
    stem = base[:dot] if dot >= 0 else base
    return hashlib.md5(stem.encode("utf-8")).hexdigest() + ".ab"


def load_build_ab_json() -> dict[str, Any]:
    """解密 Assets/data.dat → BuildABJson（ABList.PathList 是 container 索引）。"""
    if not DATA_DAT.is_file():
        raise FileNotFoundError(f"没有 {DATA_DAT}，先 download --category assets")
    raw = DATA_DAT.read_bytes()
    if raw[:1] in (b"{", b"["):
        return json.loads(raw)
    return json.loads(aes_ecb_decrypt(raw, AES_KEY))


def safe_fs_name(name: str) -> str:
    name = _UNSAFE_FS.sub("_", name).strip(" .")
    return name or "_"


def _best_label(*vals: Any) -> str:
    texts: list[str] = []
    for v in vals:
        if v is None:
            continue
        s = str(v).strip()
        if s:
            texts.append(s)
    for s in texts:
        if s != "???":
            return s
    return texts[0] if texts else ""


def load_painting_names() -> tuple[dict[str, tuple[str, str]], dict[str, str]]:
    """skinID.lower → (角色名, 皮肤名)；monsterSkin.lower → 怪物名。"""
    skins: dict[str, tuple[str, str]] = {}
    monsters: dict[str, str] = {}
    chars: dict[str, Any] = {}
    char_path = JSON_DIR / "characterTable.json"
    skin_path = JSON_DIR / "characterSkins.json"
    mon_path = JSON_DIR / "monsterMap.json"
    if char_path.is_file():
        chars = json.loads(char_path.read_text(encoding="utf-8"))
    if skin_path.is_file():
        raw_skins = json.loads(skin_path.read_text(encoding="utf-8"))
        for cid, lst in raw_skins.items():
            ch = chars.get(cid) or chars.get(cid.upper()) or chars.get(cid.lower()) or {}
            cname = _best_label(ch.get("namelanText"), ch.get("name"), cid)
            for item in lst or []:
                sid = str(item.get("skinID") or "").strip()
                if not sid:
                    continue
                sname = _best_label(
                    item.get("skinNamelanText"), item.get("skinName"), sid
                )
                skins[sid.lower()] = (cname, sname)
    if mon_path.is_file():
        for item in json.loads(mon_path.read_text(encoding="utf-8")).values():
            ms = str(item.get("monsterSkin") or "").strip().lower()
            if not ms:
                continue
            name = _best_label(item.get("NameLanText"), item.get("id"), ms)
            prev = monsters.get(ms)
            if prev is None or prev in ("???", ms) and name not in ("???", ms):
                monsters[ms] = name
    return skins, monsters


def resolve_painting_label(
    char_id: str,
    drawing_id: str,
    skins: dict[str, tuple[str, str]],
    monsters: dict[str, str],
    chars: dict[str, Any] | None = None,
) -> tuple[str, str]:
    """返回 (角色名, 皮肤/变体名)。"""
    did = drawing_id.lower()
    cid = char_id.lower()
    if did in skins:
        return skins[did]
    if did in monsters:
        return monsters[did], drawing_id
    if cid in monsters:
        return monsters[cid], drawing_id
    chars = chars or {}
    ch = chars.get(char_id) or chars.get(char_id.upper()) or chars.get(cid) or {}
    cname = _best_label(ch.get("namelanText"), ch.get("name"), char_id)
    return cname, drawing_id


def iter_drawing_abs(doc: dict[str, Any]) -> list[dict[str, str]]:
    items: list[dict[str, str]] = []
    for ab in doc.get("ABList") or []:
        logical = ab.get("Name") or ""
        md5_name = ab.get("MD5Name") or md5_ab_filename(logical)
        for path in ab.get("PathList") or []:
            m = DRAWING_PATH_RE.match(path.replace("\\", "/"))
            if not m:
                continue
            items.append(
                {
                    "logical": logical,
                    "md5": md5_name,
                    "container": path,
                    "charId": m.group(1),
                    "drawingId": m.group(2),
                }
            )
    return items


def drawing_ab_path(md5_name: str) -> Path | None:
    for dest in (BUNDLES_DIR / md5_name, ASSETS_DIR / md5_name):
        if dest.is_file():
            return dest
    return None


def extract_drawing_image(data: bytes):
    import UnityPy

    UnityPy.config.FALLBACK_UNITY_VERSION = UNITY_VERSION
    env = UnityPy.load(data)
    for mapping in (env.container, None):
        objs = (mapping.values() if mapping else env.objects)
        for obj in objs:
            try:
                t = obj.type.name
            except Exception:
                continue
            if t != "Texture2D":
                continue
            try:
                img = obj.read().image
            except Exception:
                continue
            if img is not None:
                return img
        if mapping is None:
            break
    for obj in env.objects:
        try:
            if obj.type.name != "Sprite":
                continue
            img = obj.read().image
        except Exception:
            continue
        if img is not None:
            return img
    return None


def painting_dest_name(char_name: str, variant: str) -> str:
    return f"{PAINTING_PREFIX}_{safe_fs_name(char_name)}_{safe_fs_name(variant)}.png"


def export_one_drawing(job: dict[str, Any]) -> str:
    dest: Path = job["dest"]
    if dest.is_file() and not job.get("force"):
        return "skipped"
    src: Path = job["src"]
    data = src.read_bytes()
    data, st = decrypt_unityfs_ab(data, job.get("logical") or src.name)
    if st == "fail" and parse_unityfs_header(data) is None:
        return "fail"
    img = extract_drawing_image(data)
    if img is None:
        return "fail"
    dest.parent.mkdir(parents=True, exist_ok=True)
    tmp = dest.with_suffix(".png.tmp")
    img.save(tmp, "PNG")
    tmp.replace(dest)
    return "ok"


def cmd_painting(workers: int, limit: int | None, force: bool) -> int:
    try:
        import UnityPy  # noqa: F401
    except ImportError:
        console.print("[red]需要 UnityPy：pip install UnityPy[/]")
        return 1
    try:
        doc = load_build_ab_json()
    except Exception as exc:  # noqa: BLE001
        console.print(f"[red]读 data.dat 失败[/] {exc}")
        return 1

    skins, monsters = load_painting_names()
    chars: dict[str, Any] = {}
    char_path = JSON_DIR / "characterTable.json"
    if char_path.is_file():
        chars = json.loads(char_path.read_text(encoding="utf-8"))
    drawings = iter_drawing_abs(doc)
    if limit is not None:
        drawings = drawings[: max(0, limit)]
    if not drawings:
        console.print("[red]data.dat 里没有 character/*/drawing/*.png[/]")
        return 1

    claimed: dict[str, str] = {}
    jobs: list[dict[str, Any]] = []
    missing = 0
    for item in drawings:
        src = drawing_ab_path(item["md5"])
        if src is None:
            missing += 1
            continue
        char_name, variant = resolve_painting_label(
            item["charId"], item["drawingId"], skins, monsters, chars
        )
        fname = painting_dest_name(char_name, variant)
        key = fname.lower()
        if key in claimed:
            fname = painting_dest_name(
                char_name, f"{variant}_{item['drawingId']}"
            )
            key = fname.lower()
        claimed[key] = item["drawingId"]
        jobs.append(
            {
                "src": src,
                "dest": PAINTING_DIR / fname,
                "logical": item["logical"],
                "force": force,
            }
        )

    stats = {"ok": 0, "skipped": 0, "fail": 0}
    PAINTING_DIR.mkdir(parents=True, exist_ok=True)
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("导出立绘", total=len(jobs))
        with ThreadPoolExecutor(max_workers=max(1, workers)) as pool:
            futs = [pool.submit(export_one_drawing, job) for job in jobs]
            for fut in as_completed(futs):
                st = fut.result()
                stats[st] = stats.get(st, 0) + 1
                progress.update(task, advance=1)

    named = sum(
        1
        for item in drawings
        if item["drawingId"].lower() in skins or item["drawingId"].lower() in monsters
    )
    console.print(
        f"[bold]完成[/] 导出 {stats['ok']}  已有 {stats['skipped']}  "
        f"失败 {stats['fail']}  缺 AB {missing}  "
        f"表内有名 {named}/{len(drawings)}  → {PAINTING_DIR}"
    )
    return 0 if stats["ok"] or stats["skipped"] else 1


def cmd_deserialize() -> int:
    lang: dict[str, str] = {}
    for bin_path in sorted(LANG_DIR.glob("*.bin")):
        dest, table = decode_lang_file(bin_path)
        lang.update(table)
        console.print(f"[green]lang[/] {bin_path.name} → {dest.name}  {len(table)} 条")
    if not lang:
        console.print("[yellow]没有语言包，表里的 *Lan 键不会替换成文本[/]")

    cfc_path = MASTER_DIR / "cfc_v2.bin"
    if cfc_path.exists():
        n, nj = export_cfc(cfc_path.read_bytes(), lang)
        console.print(f"[green]表[/] {cfc_path.name} → {JSON_DIR}  {nj}/{n} 张")
    else:
        console.print("[yellow]没有 cfc_v2.bin，跳过数据表[/]")

    ifix_n = 0
    for path in sorted(FIXS_DIR.glob("*.bytes")):
        try:
            dest = export_ifix(path)
        except Exception as exc:  # noqa: BLE001
            console.print(f"[yellow]IFix 跳过[/] {path.name}: {exc}")
            continue
        ifix_n += 1
        doc = json.loads(dest.read_text(encoding="utf-8"))
        console.print(
            f"[green]IFix[/] {path.name} → {dest.name}  "
            f"补丁方法 {len(doc['patchedMethods'])}  VM {doc.get('vmMethodCount', 0)}  "
            f"extern {len(doc['externMethods'])}"
        )
    if not ifix_n:
        console.print("[yellow]没有 Main_Fix_*.bytes，先 download --category fix[/]")
    clean_intermediates()
    return 0


def legacy_header_split(data: bytes) -> list[tuple[str, str, bytes]]:
    """旧拆包：BE 名长+名+目录长+目录+大小+数据。当前 s2856/fix_0 不可用。"""
    items = []
    d = 0
    n = len(data)
    while d + 8 <= n:
        nl = int.from_bytes(data[d : d + 4], "big")
        if not 0 < nl < 200:
            break
        d += 4
        name = data[d : d + nl].decode("utf-8")
        d += nl
        fl = int.from_bytes(data[d : d + 4], "big")
        d += 4
        folder = data[d : d + fl].decode("utf-8")
        d += fl
        sz = int.from_bytes(data[d : d + 4], "big")
        d += 4
        if sz < 0 or d + sz > n:
            break
        items.append((name, folder, data[d : d + sz]))
        d += sz
    return items


def collect_download_items(
    cdn: str,
    resver: str,
    packet_cfg: dict[str, Any],
    category: str,
    extra: dict[str, Any],
    limit: int | None,
    packet_names: list[str] | None,
) -> list[dict[str, Any]]:
    items: list[dict[str, Any]] = []
    client = extra.get("clientVersion") or CLIENT_VERSION

    if category in ("all", "assets"):
        files = iter_packet_files(packet_cfg)
        if packet_names:
            want = set(packet_names)
            files = [f for f in files if f.get("name") in want]
            missing = want - {f.get("name") for f in files}
            if missing:
                console.print(f"[yellow]packet_config 里没有[/] {sorted(missing)}")
        if limit is not None:
            files = files[:limit]
        for pf in files:
            items.append(
                {
                    "kind": "packet",
                    "name": pf["name"],
                    "url": url_packet(cdn, resver, pf["name"]),
                    "dest": PACKETS_DIR / pf["name"],
                    "md5": pf.get("md5") or "",
                    "size": int(pf.get("size") or 0),
                    "meta": pf,
                }
            )

    if category in ("all", "tables"):
        origin = cdn_origin(cdn)
        cfc = extra.get("cfcVersion")
        if cfc:
            items.append(
                {
                    "kind": "cfc",
                    "name": cfc,
                    "url": extra.get("cfcUrl")
                    or TMPL_CFC.format(origin=origin, md5=cfc),
                    "dest": MASTER_DIR / "cfc_v2.bin",
                    "md5": cfc if re.fullmatch(r"[0-9a-fA-F]{32}", cfc) else "",
                    "size": 0,
                    "meta": {},
                }
            )
        lang_ver = extra.get("langVersion")
        lang = (extra.get("lang") or LANG).lower()
        if lang_ver:
            items.append(
                {
                    "kind": "lang",
                    "name": f"langdata_{lang_ver}_{lang}",
                    "url": extra.get("langUrl")
                    or TMPL_LANG.format(origin=origin, ver=lang_ver, lang=lang),
                    "dest": LANG_DIR / f"{lang_ver}_{lang}.bin",
                    "md5": extra.get("langMd5") or extra.get("LangDataMd5") or "",
                    "size": 0,
                    "meta": {},
                }
            )

    if category in ("all", "fix"):
        fixver = extra.get("fixVersion")
        if fixver:
            items.append(
                {
                    "kind": "fix_config",
                    "name": FIX_CONFIG,
                    "url": url_fix_config(cdn, fixver, client),
                    "dest": FIX_DIR / FIX_CONFIG,
                    "md5": "",
                    "size": 0,
                    "meta": {"fixVersion": fixver, "client": client},
                }
            )
    return items


def expand_fix_items(cdn: str, fix_config_path: Path, extra: dict[str, Any]) -> list[dict[str, Any]]:
    doc = json.loads(fix_config_path.read_text(encoding="utf-8"))
    client = extra.get("clientVersion") or CLIENT_VERSION
    fixver = extra.get("fixVersion") or ""
    files = doc.get("fileList") or []
    items = []
    for pf in files:
        if "name" not in pf:
            continue
        items.append(
            {
                "kind": "fix_packet",
                "name": pf["name"],
                "url": url_fix_file(cdn, fixver, pf["name"], client),
                "dest": FIX_DIR / pf["name"],
                "md5": pf.get("md5") or "",
                "size": int(pf.get("size") or 0),
                "meta": pf,
            }
        )
    return items


def cmd_status(probe: bool) -> int:
    apk_cfg = load_apk_config()
    har_info = parse_har(find_har()) if find_har() else {}
    state = load_state()
    launch: dict[str, Any] = {}
    try:
        launch = fetch_launch_data()
    except Exception as exc:  # noqa: BLE001
        console.print(f"[yellow]launch 失败[/] {exc}")

    table = Table(title=GAME)
    table.add_column("项")
    table.add_column("值")
    table.add_row("APK resVersion", str(apk_cfg.get("resVersion", "-")))
    table.add_row("APK cfcVersion", str(apk_cfg.get("cfcVersion", "-")))
    table.add_row("APK lang", str(apk_cfg.get("lang", "-")))
    table.add_row("HAR", har_info.get("har", "-"))
    table.add_row("HAR AssetVersions", str(har_info.get("resVersion", "-")))
    table.add_row("HAR cfcVersion", str(har_info.get("cfcVersion", "-")))
    table.add_row("HAR fixVersion", str(har_info.get("fixVersion", "-")))
    table.add_row("HAR langVersion", str(har_info.get("langVersion", "-")))
    table.add_row("HAR cdn", str(har_info.get("cdn", "-")))
    table.add_row("xorHeader", XOR_HEADER.hex())
    table.add_row("xorHeader 文本", XOR_HEADER.split(b"\x00")[0].decode("ascii", "replace") + " / 2018.4.36f1")
    table.add_row("aesKey", AES_KEY.hex())
    table.add_row("serverAesKey", SERVER_AES_KEY.hex())
    if launch:
        table.add_row("launch SmallPack", str(launch.get("SmallPackVersion", "-")))
        table.add_row("launch ResVersion", str(launch.get("ResVersion", "-")))
        table.add_row("launch FixVersion", str(launch.get("FixVersion", "-")))
        table.add_row("launch ConfigURL_v2", str(launch.get("ConfigURL_v2", "-")))
        table.add_row("launch LangData", str(launch.get("LangData", "-")))
        table.add_row("launch VersionURL", str(launch.get("VersionURL", "-")))
    table.add_row("缓存", json.dumps(state, ensure_ascii=False) if state else "-")
    console.print(table)
    save_state({})

    extra = extra_from_launch(launch) if launch else {}
    base = (
        extra.get("resVersion")
        or har_info.get("resVersion")
        or state.get("resVersion")
        or apk_cfg.get("resVersion")
    )
    cdns = pick_cdn(extra.get("cdn") or har_info.get("cdn") or state.get("cdn"))
    if probe and base:
        try:
            cdn, resver, doc = discover_res_version(cdns, base, None, probe=True)
            cfg = current_packet_config(doc, resver)
            files = iter_packet_files(cfg)
            total = sum(int(f.get("size") or 0) for f in files)
            abs_n = sum(len(f.get("dicAB") or {}) for f in files)
            console.print(
                f"[bold]远端[/] {resver}  target={cfg.get('targetVersion')}  "
                f"包 {len(files)}  AB {abs_n}  {format_size(total)}  cdn={cdn}"
            )
        except Exception as exc:  # noqa: BLE001
            console.print(f"[red]探测失败[/] {exc}")
            return 1
    elif not launch:
        console.print("加 --probe 会从 rNNNN/sNNNN 往上请求 packet_config")
    return 0


def cmd_download(
    category: str,
    workers: int,
    retries: int,
    force: bool,
    res_version: str | None,
    keep_packets: bool,
    limit: int | None,
    cfc: str | None,
    lang_ver: int | None,
    fix_ver: str | None,
    probe: bool,
    packet_names: list[str] | None,
) -> int:
    apk_cfg = load_apk_config()
    har_info = parse_har(find_har()) if find_har() else {}
    state = load_state()

    extra: dict[str, Any] = {}
    extra.update({k: v for k, v in apk_cfg.items() if k in ("lang", "cfcVersion")})
    extra.update({k: v for k, v in har_info.items() if v})
    extra.update({k: v for k, v in state.items() if v})
    try:
        launch = fetch_launch_data()
        extra.update({k: v for k, v in extra_from_launch(launch).items() if v})
        console.print(
            f"[green]launch[/] SmallPack={launch.get('SmallPackVersion')}  "
            f"Fix={launch.get('FixVersion')}  cfc={launch.get('ConfigVersion_v2')}"
        )
    except Exception as exc:  # noqa: BLE001
        console.print(f"[yellow]launch 失败，回退 HAR/缓存[/] {exc}")
    if cfc:
        extra["cfcVersion"] = cfc
        extra.pop("cfcUrl", None)
    if lang_ver:
        extra["langVersion"] = lang_ver
        extra.pop("langUrl", None)
    if fix_ver:
        extra["fixVersion"] = fix_ver
    extra.setdefault("clientVersion", CLIENT_VERSION)
    extra.setdefault("lang", apk_cfg.get("lang") or LANG)

    cdns = pick_cdn(extra.get("cdn"))
    base = res_version or extra.get("resVersion") or apk_cfg.get("resVersion")
    cdn, resver, doc = discover_res_version(cdns, str(base) if base else None, res_version, probe)
    packet_cfg = current_packet_config(doc, resver)
    (ASSETS_DIR / "packet_config.json").parent.mkdir(parents=True, exist_ok=True)
    (ASSETS_DIR / "packet_config.json").write_text(
        json.dumps(doc, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )

    items = collect_download_items(
        cdn, resver, packet_cfg, category, extra, limit, packet_names
    )
    if not items and category in ("all", "tables") and not extra.get("cfcVersion"):
        console.print("[yellow]没有 cfcVersion：数据表 URL 要 HAR / --cfc / 登录后的 ConfigURL[/]")
    if not items:
        console.print("[red]没有可下载项[/]")
        return 1

    total_bytes = sum(int(i.get("size") or 0) for i in items)
    console.print(
        f"{GAME} {resver}  target={packet_cfg.get('targetVersion')}  "
        f"{len(items)} 个文件 / {format_size(total_bytes)}  cdn={cdn}"
    )

    stats = {"ok": 0, "skip": 0, "fail": 0}
    errors: list[str] = []
    done_bytes = 0
    bytes_lock = threading.Lock()
    cdn_urls_for = lambda item: failover_urls(item["url"], cdn, cdns)

    progress_total = total_bytes if total_bytes else len(items)
    columns = [
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
    ]
    if total_bytes:
        columns.extend([DownloadColumn(), TransferSpeedColumn(), TimeRemainingColumn()])
    else:
        columns.append(TimeRemainingColumn())
    with Progress(*columns, console=console) as progress:
        task = progress.add_task("下载", total=max(progress_total, 1))

        def work(item: dict[str, Any]) -> tuple[str, dict[str, Any], str]:
            note = ""
            if item["kind"] in ("packet", "fix_packet") and not force:
                if packet_already_split(item.get("meta") or {}):
                    d, _s = xor_decrypt_packet(item.get("meta") or {})
                    note = f"XOR 解密 {d}" if d else ""
                    return "skip", item, note
            status = download_file(
                cdn_urls_for(item),
                item["dest"],
                expected_md5=item.get("md5") or "",
                expected_size=int(item.get("size") or 0),
                retries=retries,
                force=force,
            )
            if item["kind"] in ("packet", "fix_packet") and item["dest"].exists():
                keep = keep_packets
                ok_n, fail_n = split_packet_file(item["dest"], item["meta"], keep)
                if fail_n:
                    raise RuntimeError(f"dicAB 切片失败 {fail_n}/{ok_n + fail_n}")
                note = f"切片 {ok_n}（已 XOR）"
            elif item["kind"] == "cfc" and item["dest"].exists():
                note = "密文缓存"
            elif item["kind"] == "lang" and item["dest"].exists():
                note = "密文缓存"
            return status, item, note

        with ThreadPoolExecutor(max_workers=max(1, workers)) as pool:
            futures = {pool.submit(work, it): it for it in items}
            for fut in as_completed(futures):
                item = futures[fut]
                try:
                    status, item, note = fut.result()
                    stats[status] = stats.get(status, 0) + 1
                    if note:
                        console.print(f"[green]{item['name']}[/] {note}")
                    if item["kind"] == "fix_config" and item["dest"].exists():
                        extra_fix = expand_fix_items(cdn, item["dest"], extra)
                        for fx in extra_fix:
                            st, fx, fx_note = work(fx)
                            stats[st] = stats.get(st, 0) + 1
                            if fx_note:
                                console.print(f"[green]{fx['name']}[/] {fx_note}")
                except Exception as exc:  # noqa: BLE001
                    stats["fail"] += 1
                    errors.append(f"{item['name']}: {exc}")
                    console.print(f"[red]FAIL[/] {item['name']}: {exc}")
                with bytes_lock:
                    step = int(item.get("size") or 0) if total_bytes else 1
                    done_bytes += step
                    progress.update(task, completed=min(done_bytes, progress_total))

    save_state(
        {
            "resVersion": resver,
            "targetVersion": packet_cfg.get("targetVersion"),
            "cdn": cdn,
            "cfcVersion": extra.get("cfcVersion"),
            "langVersion": extra.get("langVersion"),
            "fixVersion": extra.get("fixVersion"),
            "clientVersion": extra.get("clientVersion"),
            "lang": extra.get("lang"),
            "category": category,
        }
    )
    console.print()
    console.print(
        f"[bold]完成[/] 下载 {stats['ok']}  跳过 {stats['skip']}  失败 {stats['fail']}"
    )
    if errors:
        err_log = ROOT / "download_errors.log"
        err_log.write_text("\n".join(errors) + "\n", encoding="utf-8")
        console.print(f"[yellow]错误写入 {err_log} ({len(errors)})[/]")
        return 1
    if category in ("all", "tables", "fix"):
        cmd_deserialize()
    return 0


def cmd_split_cfc(path: Path) -> int:
    lang: dict[str, str] = {}
    for bin_path in sorted(LANG_DIR.glob("*.bin")):
        _dest, table = decode_lang_file(bin_path)
        lang.update(table)
    n, nj = export_cfc(path.read_bytes(), lang)
    console.print(f"拆出 {n} 张表，解密 JSON {nj} → {JSON_DIR}")
    clean_intermediates()
    return 0 if n else 1


def cmd_decrypt_assets(workers: int) -> int:
    """还原误解密，再按 UnityFS [50,122] XOR 解密（key=ciphertext[51]）。"""
    if lz4_block is None:
        console.print("[red]需要 lz4：pip install lz4[/]")
        return 1
    packets: list[dict[str, Any]] = []
    cfg_path = ASSETS_DIR / "packet_config.json"
    if cfg_path.exists():
        doc = normalize_packet_doc(json.loads(cfg_path.read_text(encoding="utf-8"))) or {}
        for cfg in doc.get("list") or []:
            packets.extend(iter_packet_files(cfg))
    fix_cfg = FIX_DIR / FIX_CONFIG
    if fix_cfg.exists():
        packets.extend(json.loads(fix_cfg.read_text(encoding="utf-8")).get("fileList") or [])
    abs_list: list[dict[str, Any]] = []
    for pf in packets:
        for ab in (pf.get("dicAB") or {}).values():
            if ab_dest(ab).is_file():
                abs_list.append(ab)
    if not abs_list:
        console.print("[red]没有已切片的 AB，先 download --category assets[/]")
        return 1

    stats = {"decrypted": 0, "skipped": 0, "plain": 0, "fail": 0}
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("XOR 解密", total=len(abs_list))

        def work(ab: dict[str, Any]) -> str:
            return xor_decrypt_file(ab_dest(ab), ab["name"], ab.get("md5") or "")

        with ThreadPoolExecutor(max_workers=max(1, workers)) as pool:
            futs = [pool.submit(work, ab) for ab in abs_list]
            for fut in as_completed(futs):
                st = fut.result()
                stats[st] = stats.get(st, 0) + 1
                progress.update(task, advance=1)

    save_state({"xorDecrypted": True})
    console.print(
        f"[bold]完成[/] 解密 {stats['decrypted']}  已是明文 {stats['skipped']}  "
        f"无需 XOR {stats['plain']}  失败 {stats.get('fail', 0)}"
    )
    return 0


def cmd_verify_legacy(path: Path) -> int:
    data = path.read_bytes()
    items = legacy_header_split(data)
    console.print(f"旧头解析得到 {len(items)} 个文件（当前官方包应为 0）")
    for name, folder, blob in items[:8]:
        console.print(f"  {folder}/{name} {len(blob)}")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=f"{GAME} 资源/数据表下载更新")
    sub = parser.add_subparsers(dest="cmd", required=True)

    p_st = sub.add_parser("status", help="查看 APK / HAR / launch / 远端 packet_config")
    p_st.add_argument("--probe", action="store_true", help="从 rNNNN 对应的 sNNNN 往上探测")

    p_dl = sub.add_parser("download", help="下载资源包 / 数据表 / 热修")
    p_dl.add_argument(
        "--category",
        choices=("all", "assets", "tables", "masterdata", "fix"),
        default="all",
        help="all=资源+数据表+热修；assets=packet AB；tables/masterdata=cfc+语言包；fix=热修",
    )
    p_dl.add_argument("--workers", type=int, default=8)
    p_dl.add_argument("--retries", type=int, default=RETRY_COUNT)
    p_dl.add_argument("--force", action="store_true")
    p_dl.add_argument("--res-version", help="例如 s2856；不传则 HAR/缓存/探测")
    p_dl.add_argument("--probe", action="store_true", help="从基准版本往上扫最新 sXXXX")
    p_dl.add_argument("--keep-packets", action="store_true", help="切片后保留原始 packet")
    p_dl.add_argument("--limit", type=int, default=None, help="只下前 N 个 packet（调试）")
    p_dl.add_argument("--packet", action="append", default=None, help="只下指定 packet 名，可重复，例如 s2856_61")
    p_dl.add_argument("--cfc", help="cfc_v2 的 md5（ServerData.ConfigURL）")
    p_dl.add_argument("--lang-ver", type=int, help="langdata_v3 版本号")
    p_dl.add_argument("--fix-ver", help="例如 f3376")

    p_md = sub.add_parser("masterdata", help="只下载并解密数据表（cfc + 语言包），不下 AB")
    p_md.add_argument("--workers", type=int, default=8)
    p_md.add_argument("--retries", type=int, default=RETRY_COUNT)
    p_md.add_argument("--force", action="store_true")
    p_md.add_argument("--cfc", help="cfc_v2 的 md5；不传则 launch/HAR")
    p_md.add_argument("--lang-ver", type=int, help="langdata_v3 版本号")

    p_cfc = sub.add_parser("split-cfc", help="把已下载的 cfc_v2.bin / data_config 拆成表")
    p_cfc.add_argument("path", type=Path)

    p_xor = sub.add_parser("decrypt-assets", help="解密已切片 AB 的 UnityFS blocks info XOR")
    p_xor.add_argument("--workers", type=int, default=8)

    sub.add_parser(
        "deserialize",
        help="解析 Main_Fix IFix 补丁、语言包，并把数据表里能解的字段都解开",
    )

    p_lg = sub.add_parser("verify-legacy", help="用旧 64 字节头试拆一个文件，确认是否已废弃")
    p_lg.add_argument("path", type=Path)

    p_pt = sub.add_parser(
        "painting",
        help="从 data.dat 索引导出 character/*/drawing 立绘到 Painting/",
    )
    p_pt.add_argument("--workers", type=int, default=8)
    p_pt.add_argument("--limit", type=int, default=None, help="只导出前 N 张（调试）")
    p_pt.add_argument("--force", action="store_true", help="覆盖已有 PNG")

    args = parser.parse_args()
    if args.cmd == "status":
        return cmd_status(probe=args.probe)
    if args.cmd == "download":
        category = "tables" if args.category == "masterdata" else args.category
        return cmd_download(
            category=category,
            workers=args.workers,
            retries=args.retries,
            force=args.force,
            res_version=args.res_version,
            keep_packets=args.keep_packets,
            limit=args.limit,
            cfc=args.cfc,
            lang_ver=args.lang_ver,
            fix_ver=args.fix_ver,
            probe=args.probe,
            packet_names=args.packet,
        )
    if args.cmd == "masterdata":
        return cmd_download(
            category="tables",
            workers=args.workers,
            retries=args.retries,
            force=args.force,
            res_version=None,
            keep_packets=False,
            limit=None,
            cfc=args.cfc,
            lang_ver=args.lang_ver,
            fix_ver=None,
            probe=False,
            packet_names=None,
        )
    if args.cmd == "split-cfc":
        return cmd_split_cfc(args.path)
    if args.cmd == "decrypt-assets":
        return cmd_decrypt_assets(workers=args.workers)
    if args.cmd == "deserialize":
        return cmd_deserialize()
    if args.cmd == "verify-legacy":
        return cmd_verify_legacy(args.path)
    if args.cmd == "painting":
        return cmd_painting(workers=args.workers, limit=args.limit, force=args.force)
    parser.error("unknown command")
    return 2


if __name__ == "__main__":
    raise SystemExit(main())
