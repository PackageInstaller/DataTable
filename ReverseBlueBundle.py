from __future__ import annotations

"""反向蓝资源 bundle 的下载 / 完整性校验 / 解密。

1.31.3 客户端所有 asset bundle 均为未加密的 UnityFS（APK 内置、split assetpack、
CDN 热更三种来源都验证过），因此默认无需解密；如后续版本对 bundle 加密，
在 ensure_plain() 里补充对应解密实现即可，其余流程无需改动。
"""

import threading
import time
from pathlib import Path
from typing import Any

import requests
from rich.console import Console

CHUNK = 1 << 20
RETRY = 4
TIMEOUT = 120

UNITY_MAGICS = (b"UnityFS", b"UnityWeb", b"UnityRaw", b"UnityArchive")

_tls = threading.local()


def _thread_session() -> requests.Session:
    """每个下载线程复用一个 Session，避免 1.6 万个文件重复 TLS 握手。"""
    session = getattr(_tls, "session", None)
    if session is None:
        session = requests.Session()
        _tls.session = session
    return session


def is_unity_bundle(head: bytes) -> bool:
    return any(head.startswith(magic) for magic in UNITY_MAGICS)


def download(
    url: str,
    dest: Path,
    *,
    expected_size: int = 0,
    force: bool = False,
    timeout: int = TIMEOUT,
    headers: dict[str, str] | None = None,
    on_bytes: Any | None = None,
) -> str:
    """下载到 dest；已存在且大小一致则跳过。返回 ok / skip。"""
    dest.parent.mkdir(parents=True, exist_ok=True)
    if not force and dest.is_file():
        size = dest.stat().st_size
        if expected_size and size == expected_size:
            if on_bytes is not None:
                on_bytes(size)
            return "skip"
    tmp = dest.with_suffix(dest.suffix + ".part")
    last: Exception | None = None
    for attempt in range(1, RETRY + 1):
        got = 0
        try:
            with _thread_session().get(url, stream=True, timeout=timeout, headers=headers or {}) as resp:
                resp.raise_for_status()
                total = int(resp.headers.get("Content-Length") or 0)
                with tmp.open("wb") as handle:
                    for chunk in resp.iter_content(CHUNK):
                        if not chunk:
                            continue
                        handle.write(chunk)
                        got += len(chunk)
                        if on_bytes is not None:
                            on_bytes(len(chunk))
                size = tmp.stat().st_size
                if expected_size and size != expected_size:
                    raise RuntimeError(f"size {size} != {expected_size} ({url})")
                if total and size != total:
                    raise RuntimeError(f"size {size} != Content-Length {total} ({url})")
                tmp.replace(dest)
                return "ok"
        except Exception as exc:  # noqa: BLE001
            last = exc
            tmp.unlink(missing_ok=True)
            time.sleep(0.4 * attempt)
    raise RuntimeError(f"下载失败 {url}: {last}")


def ensure_plain(path: Path, console: Console | None = None) -> str:
    """确认 bundle 为明文 UnityFS；如加密则在此解密。返回 plain / decrypted / fail。"""
    with path.open("rb") as handle:
        head = handle.read(64)
    if is_unity_bundle(head):
        return "plain"
    # 预留：后续版本若对 bundle 加密，在此实现解密并覆盖原文件
    if console is not None:
        console.print(f"[yellow]bundle 非 UnityFS（疑似加密，尚未实现解密）[/yellow] {path}")
    return "fail"
