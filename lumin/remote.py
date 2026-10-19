from __future__ import annotations

import hashlib
import json
import os
import random
import time
import urllib.error
import urllib.parse
import urllib.request
from dataclasses import dataclass, field
from pathlib import Path

API_URL = "https://lmapi.zhuziplay.com/remote/config"
USER_AGENT = "UnityPlayer/2022.3.62f2 (UnityWebRequest/1.0, libcurl/8.0.1-DEV)"

DEFAULT_FORM = {
    "build_id": "12451",
    "target_platform": "Android",
    "region": "CN",
    "env": "Prod",
    "channel": "zhuzi_taptap",
    "client_version": "1.0.5",
    "device_id": "35f9cbe75c378cc0",
    "assets_version": "0",
    "raw_file_version": "0",
    "client_static_version": "0",
    "dll_version": "0",
    "aid": "6494933",
    "cps_group": "taptap",
}


PACKAGE_KEYS = {
    "assets": "Assets",
    "client_static": "ClientStatic",
    "dll": "Dll",
    "raw_file": "RawFile",
}


@dataclass
class ZipEntry:
    url: str
    size: int
    md5: str
    tag: str

    @property
    def name(self) -> str:
        return self.url.rsplit("/", 1)[-1]


@dataclass
class PackageInfo:
    name: str
    version: int
    cdn: str
    backup_cdn: str
    manifest_prefix: str
    bundle_prefix: str
    zips: list[ZipEntry] = field(default_factory=list)

    def zip_url(self, entry: ZipEntry) -> str:
        return self.cdn + entry.url

    def manifest_url(self, template: str | None = None, *, backup: bool = False) -> str:
        template = template or "{pkg}_prod_1.0.0_prod.a_{ver}.bytes"
        filename = template.format(pkg=self.name, ver=self.version)
        host = self.backup_cdn if backup and self.backup_cdn else self.cdn
        return f"{host}{self.manifest_prefix}/{self.name}/{self.version}/{filename}"


def _random_device_id() -> str:
    return "".join(random.choice("0123456789abcdef") for _ in range(16))


def fetch_config(
    form: dict[str, str] | None = None,
    *,
    timeout: int = 30,
    save_path: Path | None = None,
) -> dict:
    body = dict(DEFAULT_FORM)
    if form:
        body.update({k: str(v) for k, v in form.items()})
    data = urllib.parse.urlencode(body).encode()
    req = urllib.request.Request(
        API_URL,
        data=data,
        headers={
            "Content-Type": "application/x-www-form-urlencoded",
            "User-Agent": USER_AGENT,
        },
        method="POST",
    )
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        raw = resp.read()
    cfg = json.loads(raw.decode("utf-8"))
    if cfg.get("code") != 0:
        raise RuntimeError(f"远端配置返回错误: {cfg}")
    if save_path:
        save_path.parent.mkdir(parents=True, exist_ok=True)
        save_path.write_text(json.dumps(cfg, ensure_ascii=False, indent=2), encoding="utf-8")
    return cfg


def parse_config(cfg: dict) -> dict[str, PackageInfo]:
    data = cfg.get("data", cfg)
    out: dict[str, PackageInfo] = {}
    for key, pkg_name in PACKAGE_KEYS.items():
        node = data.get(key)
        if not node:
            continue
        normal = node.get("normal") or {}
        zips = [
            ZipEntry(
                url=z["url"],
                size=int(z.get("size") or 0),
                md5=z.get("hash") or "",
                tag=z.get("tag") or "Default",
            )
            for z in normal.get("full", [])
        ]
        out[pkg_name] = PackageInfo(
            name=pkg_name,
            version=int(normal.get("version") or 0),
            cdn=node.get("cdn") or "",
            backup_cdn=node.get("backup_cdn") or "",
            manifest_prefix=node.get("manifest_prefix") or "",
            bundle_prefix=node.get("bundle_prefix") or "",
            zips=zips,
        )
    return out


def _md5_file(path: Path, chunk: int = 1 << 20) -> str:
    h = hashlib.md5()
    with open(path, "rb") as fh:
        while True:
            block = fh.read(chunk)
            if not block:
                break
            h.update(block)
    return h.hexdigest()


def download_file(
    url: str,
    dest: Path,
    *,
    expected_size: int | None = None,
    expected_md5: str | None = None,
    resume: bool = True,
    retries: int = 3,
    timeout: int = 120,
    progress=None,
) -> Path:
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.is_file():
        if expected_size and dest.stat().st_size == expected_size:
            if not expected_md5 or _md5_file(dest) == expected_md5:
                if progress:
                    progress(dest.name, expected_size, expected_size, True)
                return dest
        if not resume:
            dest.unlink()

    part = dest.with_name(dest.name + ".part")
    if expected_size and part.is_file() and part.stat().st_size > expected_size:
        part.unlink()
    if expected_size and part.is_file() and part.stat().st_size == expected_size:
        if not expected_md5 or _md5_file(part) == expected_md5:
            os.replace(part, dest)
            if progress:
                progress(dest.name, expected_size, expected_size, True)
            return dest
        part.unlink()
    last_error: Exception | None = None
    for attempt in range(1, retries + 1):
        try:
            existing = part.stat().st_size if (resume and part.is_file()) else 0
            headers = {"User-Agent": USER_AGENT}
            if existing:
                headers["Range"] = f"bytes={existing}-"
            req = urllib.request.Request(url, headers=headers)
            with urllib.request.urlopen(req, timeout=timeout) as resp:
                mode = "ab" if existing and resp.status == 206 else "wb"
                if mode == "wb":
                    existing = 0
                total = expected_size or 0
                if not total:
                    length = resp.headers.get("Content-Length")
                    total = existing + int(length) if length else 0
                done = existing
                with open(part, mode) as fh:
                    while True:
                        chunk = resp.read(1 << 20)
                        if not chunk:
                            break
                        fh.write(chunk)
                        done += len(chunk)
                        if progress:
                            progress(dest.name, done, total, False)
            size = part.stat().st_size
            if expected_size and size != expected_size:
                raise IOError(f"大小不符: {size} != {expected_size}")
            if expected_md5:
                actual = _md5_file(part)
                if actual.lower() != expected_md5.lower():
                    raise IOError(f"MD5 不符: {actual} != {expected_md5}")
            os.replace(part, dest)
            if progress:
                progress(dest.name, size, size, True)
            return dest
        except urllib.error.HTTPError as exc:  # noqa: BLE001
            last_error = exc
            if exc.code == 416:
                if part.is_file():
                    part.unlink()
            if attempt < retries:
                time.sleep(min(2 * attempt, 10))
        except Exception as exc:  # noqa: BLE001
            last_error = exc
            if attempt < retries:
                time.sleep(min(2 * attempt, 10))
    raise IOError(f"下载失败 {url}: {last_error}")


def download_manifest(
    pkg: PackageInfo,
    out_dir: Path,
    *,
    template: str | None = None,
    force: bool = False,
    progress=None,
) -> Path:
    out_dir.mkdir(parents=True, exist_ok=True)
    final = out_dir / f"{pkg.name}_{pkg.version}.bytes"
    if final.is_file() and not force:
        return final
    templates = [template] if template else [
        "{pkg}_prod_1.0.0_prod.a_{ver}.bytes",
        "{pkg}_prod_1.0.0_prod.a_{ver}",
        "{pkg}_{ver}.bytes",
    ]
    errors = []
    urls = []
    for tmpl in templates:
        if not tmpl:
            continue
        urls.append(pkg.manifest_url(tmpl))
        if pkg.backup_cdn:
            urls.append(pkg.manifest_url(tmpl, backup=True))
    for url in urls:
        try:
            return download_file(url, final, retries=2, progress=progress)
        except Exception as exc:  # noqa: BLE001
            errors.append(f"{url}: {exc}")
    raise IOError("清单下载失败:\n" + "\n".join(errors))


def extract_zip(
    zip_path: Path,
    out_dir: Path,
    *,
    force: bool = False,
    hash_map: dict[str, str] | None = None,
) -> int:
    import zipfile

    count = 0
    out_dir.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(zip_path) as zf:
        for info in zf.infolist():
            if not info.filename.endswith("/__data"):
                continue
            parts = info.filename.split("/")
            file_hash = parts[1] if len(parts) >= 2 else ""
            rel = hash_map.get(file_hash) if (hash_map and file_hash in hash_map) else info.filename
            dest = out_dir / rel
            if dest.is_file() and not force and dest.stat().st_size == info.file_size:
                count += 1
                continue
            dest.parent.mkdir(parents=True, exist_ok=True)
            with zf.open(info) as src, open(dest, "wb") as dst:
                while True:
                    chunk = src.read(1 << 20)
                    if not chunk:
                        break
                    dst.write(chunk)
            count += 1
    return count

