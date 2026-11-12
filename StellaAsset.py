from __future__ import annotations

import json
import re
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Callable

import requests
from rich.console import Console
from rich.progress import (
    Progress
)

from StellaCrypto import (
    CDN_HOST,
    SERVER_META_KEY,
    decrypt_aes_meta,
    depad_asset_data,
    get_cdn_url,
    md5_file,
    parse_meta_manifest,
)

DEFAULT_TIMEOUT = (15, 60)
CHUNK_SIZE = 1024 * 1024


def get_asset_rel_path(name: str) -> Path:
    clean = re.sub(r"^p_\d+_[num]\.", "", name)
    ext = clean.split(".")[-1].lower() if "." in clean else ""
    if ext == "unity3d":
        parts = clean.split("_")
        if len(parts) > 1:
            return Path(*parts[:-1]) / parts[-1]
        else:
            return Path(clean)
    elif ext in ("wem", "mp4", "bnk", "srt"):
        return Path(ext) / clean
    else:
        return Path(clean)


class StellaAssetManager:
    def __init__(
        self,
        assets_dir: Path,
        apk_path: Path | None = None,
        console: Console | None = None,
        cdn_host: str = CDN_HOST,
        meta_key: bytes = SERVER_META_KEY,
    ):
        self.assets_dir = assets_dir
        self.apk_path = apk_path
        self.console = console or Console()
        self.cdn_host = cdn_host
        self.meta_key = meta_key
        self.assets_dir.mkdir(parents=True, exist_ok=True)
        self.manifest_file = self.assets_dir / ".manifest.json"

    def fetch_remote_manifest(self) -> dict[str, dict[str, Any]]:
        url = f"{self.cdn_host}/meta/and.html"
        resp = requests.get(url, timeout=DEFAULT_TIMEOUT)
        resp.raise_for_status()
        decrypted = decrypt_aes_meta(resp.content, self.meta_key)
        return parse_meta_manifest(decrypted)

    def extract_from_apk(
        self,
        force: bool = False,
        progress: Progress | None = None,
    ) -> tuple[int, int, int]:
        ok_count = 0
        skip_count = 0
        fail_count = 0

        with zipfile.ZipFile(self.apk_path, "r") as z:
            install_files = [
                name
                for name in z.namelist()
                if name.startswith("assets/InstallResource/") and not name.endswith("/")
            ]

            prog_task = None
            if progress is not None:
                prog_task = progress.add_task("[cyan]提取 APK 内置资产...", total=len(install_files))

            for name in install_files:
                basename = Path(name).name
                rel_path = get_asset_rel_path(basename)
                out_path = self.assets_dir / rel_path

                if out_path.exists() and not force:
                    skip_count += 1
                    if progress is not None and prog_task is not None:
                        progress.advance(prog_task)
                    continue

                try:
                    out_path.parent.mkdir(parents=True, exist_ok=True)
                    raw_data = z.read(name)
                    clean_data = depad_asset_data(raw_data)
                    out_path.write_bytes(clean_data)
                    ok_count += 1
                except Exception as ex:
                    fail_count += 1
                    if self.console:
                        self.console.print(f"[red]提取 APK 文件失败[/red] {basename}: {ex}")

                if progress is not None and prog_task is not None:
                    progress.advance(prog_task)

        return (ok_count, skip_count, fail_count)

    def download_and_sync(
        self,
        manifest: dict[str, dict[str, Any]] | None = None,
        jobs: int = 16,
        force: bool = False,
        limit: int = 0,
        progress: Progress | None = None,
        filter_fn: Callable[[str], bool] | None = None,
    ) -> tuple[int, int, int]:
        if manifest is None:
            manifest = self.fetch_remote_manifest()

        items_to_download: list[dict[str, Any]] = []

        for name, info in manifest.items():
            if re.match(r"^p_\d+_[num]\.", name):
                continue
            if filter_fn is not None and not filter_fn(name):
                continue

            rel_path = get_asset_rel_path(name)
            out_path = self.assets_dir / rel_path
            expected_md5 = info["md5"]

            if out_path.exists() and not force:
                if expected_md5:
                    if md5_file(out_path).lower() == expected_md5.lower():
                        continue
                else:
                    continue

            url = get_cdn_url(name, manifest, host=self.cdn_host)
            if url:
                items_to_download.append(
                    {
                        "name": name,
                        "url": url,
                        "out_path": out_path,
                        "expected_md5": expected_md5,
                    }
                )
            if 0 < limit <= len(items_to_download):
                break

        if not items_to_download:
            return (0, len(manifest), 0)

        prog_task = None
        if progress is not None:
            prog_task = progress.add_task("[cyan]下载热更资产...", total=len(items_to_download))

        ok_count = 0
        skip_count = len(manifest) - len(items_to_download)
        fail_count = 0

        def _download_one(item: dict[str, Any]) -> tuple[bool, str, str]:
            name = item["name"]
            url = item["url"]
            out_path = item["out_path"]
            expected_md5 = item["expected_md5"]

            for attempt in range(3):
                try:
                    resp = requests.get(url, timeout=DEFAULT_TIMEOUT, stream=True)
                    if resp.status_code == 404:
                        return (False, name, "404 Not Found")
                    resp.raise_for_status()

                    raw_bytes = resp.content
                    clean_bytes = depad_asset_data(raw_bytes)

                    # 校验与写出
                    out_path.parent.mkdir(parents=True, exist_ok=True)
                    out_path.write_bytes(clean_bytes)
                    return (True, name, "ok")
                except Exception as ex:
                    if attempt == 2:
                        return (False, name, str(ex))
            return (False, name, "retry exhausted")

        with ThreadPoolExecutor(max_workers=jobs) as executor:
            futures = [executor.submit(_download_one, item) for item in items_to_download]
            for fut in as_completed(futures):
                success, name, status = fut.result()
                if success:
                    ok_count += 1
                else:
                    fail_count += 1
                    if self.console:
                        self.console.print(f"[yellow]下载失败[/yellow] {name}: {status}")

                if progress is not None and prog_task is not None:
                    progress.advance(prog_task)

        self.save_manifest_cache(manifest)
        return (ok_count, skip_count, fail_count)

    def save_manifest_cache(self, manifest: dict[str, dict[str, Any]]) -> None:
        try:
            self.manifest_file.write_text(
                json.dumps(manifest, ensure_ascii=False, indent=2),
                encoding="utf-8",
            )
        except Exception:
            pass
