#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
OtogiFrontierR.py

《童话边境》（オトギフロンティア R / Otogi Frontier R）全自动数据表与资产/立绘提取工具
- 全自动版本探测（直连 DMM 网关获取最新 X-OtogiSp-AssetsVersion）
- 子命令架构：status, version, masterdata, assets, painting, all
- 数据表全自动下载解压（11 个核心业务表转为格式化 JSON）
- 游戏完整 WebGL 资源下载与 AES-CBC 流式解密（UnityFS 还原）
- 角色立绘提取模式（对齐 CatFantasy 规范：童话边境_角色名_形态X_ID.png，优先提取 standimagelarge 完整大立绘）
"""

from __future__ import annotations

import argparse
import gzip
import io
import json
import os
import re
import shutil
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Set, Tuple

import pandas as pd
import requests
import UnityPy
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
from PIL import Image
from rich.console import Console
from rich.panel import Panel
from rich.progress import (
    BarColumn,
    DownloadColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TaskProgressColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)
from rich.table import Table

# ==============================================================================
# 全局常量与配置
# ==============================================================================
GAME_TITLE = "童话边境"
ENV_URL = (
    "https://osapi.dmm.com/gadgets/makeRequest?"
    "url=http://otogi-sp.trafficmanager.net/api/Configuration/Environment&httpMethod=POST"
)
WEBGL_MANIFEST_URL = "https://web-assets.otogi-frontier.com/prodassets/GeneralWebGL/Assets/WebGL"
ASSET_BASE_URL = "https://web-assets.otogi-frontier.com/prodassets/GeneralWebGL/Assets/"
MASTERDATA_URL = "https://web-assets.otogi-frontier.com/prodassets/MasterData/"
PATCH_URL_TEMPLATE = (
    "https://web-assets.otogi-frontier.com/prodassets/GeneralWebGL/AssetBundlePatch/"
    "{version}/0_{version}{suffix}.csv"
)

MASTERDATA_FILES = [
    "MAccessory.gz",
    "MFoods.gz",
    "MItems.gz",
    "MMaterials.gz",
    "MMonsters.gz",
    "MRecipes.gz",
    "MSkills.gz",
    "MSpirits.gz",
    "MTrophies.gz",
    "MWeapons.gz",
    "SkillFilters.gz",
]

# AES-128-CBC 解密密钥与 IV
KEY = b"kms1kms2kms3kms4"
IV = b"nekonekonyannyan"
UNITYFS_MAGIC = b"UnityFS"
HEAD_LEN = 7

DEFAULT_JOBS = 16
DEFAULT_TIMEOUT = 30
DEFAULT_RETRIES = 5

console = Console()


# ==============================================================================
# 加解密与文件工具函数
# ==============================================================================
def decrypt_blob(enc: bytes) -> Optional[bytes]:
    """AES-128-CBC 解密资源数据块，并检验 UnityFS 魔数"""
    try:
        text = unpad(AES.new(KEY, AES.MODE_CBC, IV).decrypt(enc), AES.block_size)
        return text if text[:HEAD_LEN] == UNITYFS_MAGIC else text
    except Exception:
        return None


def need_decrypt(data: bytes) -> bool:
    """判断数据是否尚未解密（未以 UnityFS 开头）"""
    return data[:HEAD_LEN] != UNITYFS_MAGIC


def _safe_fs_name(name: str) -> str:
    """过滤文件名中的非法字符，转为全角或安全字符（对齐 CatFantasy 规范）"""
    table = str.maketrans(
        {
            "/": "／",
            "\\": "＼",
            ":": "：",
            "*": "＊",
            "?": "？",
            '"': "'",
            "<": "＜",
            ">": "＞",
            "|": "｜",
            "\n": "",
            "\r": "",
            "\t": " ",
        }
    )
    out = name.translate(table).strip()
    return out or "未知"


def painting_filename(
    cha: str,
    skin: str,
    used: set[str],
    notes: Iterable[str] | None = None,
) -> str:
    """
    CatFantasy 规范立绘命名格式：
    游戏名_角色名_皮肤/变体名[_备注1_备注2...].png
    """
    parts = [GAME_TITLE, _safe_fs_name(cha), _safe_fs_name(skin)]
    for note in notes or []:
        cleaned = _safe_fs_name(str(note))
        if cleaned and cleaned != "未知":
            parts.append(cleaned)
    base = "_".join(parts) + ".png"
    if base not in used:
        used.add(base)
        return base
    n = 2
    while True:
        name = "_".join(parts + [str(n)]) + ".png"
        if name not in used:
            used.add(name)
            return name
        n += 1


# ==============================================================================
# 版本探测与清单解析
# ==============================================================================
def get_environment_ver(timeout: int = DEFAULT_TIMEOUT) -> str:
    """直连网关获取最新游戏资源版本号"""
    try:
        resp = requests.get(ENV_URL, timeout=timeout)
        resp.raise_for_status()
        raw_text = resp.text
        clean_json = re.sub(r"^throw 1;.*?\{", "{", raw_text, count=1, flags=re.DOTALL)
        data = json.loads(clean_json)
        headers = data["http://otogi-sp.trafficmanager.net/api/Configuration/Environment"]["headers"]
        ver = str(headers["X-OtogiSp-AssetsVersion"])
        return ver
    except Exception as e:
        raise RuntimeError(f"获取版本号失败: {e}")


def load_manifest_tree(path: Path) -> Any:
    """加载并解析 WebGL AssetBundleManifest"""
    env = UnityPy.load(str(path))
    for obj in env.objects:
        if obj.type.name == "AssetBundleManifest":
            return obj.read_typetree()
    return None


def download_webgl_manifest(dest_dir: Path = Path(".")) -> List[str]:
    """下载并解析 WebGL 全量清单"""
    manifest_path = dest_dir / "WebGL"
    resp = requests.get(WEBGL_MANIFEST_URL, timeout=DEFAULT_TIMEOUT)
    resp.raise_for_status()
    manifest_path.write_bytes(resp.content)

    tree = load_manifest_tree(manifest_path)
    if not tree:
        return []
    idx2name = {int(i): n for i, n in tree["AssetBundleNames"]}
    names = [idx2name[int(e[0])] for e in tree["AssetBundleInfos"]]
    pd.DataFrame({"AssetBundleName": names}).to_csv(dest_dir / "WebGL.csv", index=False)
    return names


def download_patch_list(ver: str, timeout: int = DEFAULT_TIMEOUT) -> Tuple[List[str], Dict[str, int]]:
    """下载并解析远端热更补丁清单 CSV"""
    size_map: Dict[str, int] = {}
    names: List[str] = []
    for suf in ["", "_ad"]:
        url = PATCH_URL_TEMPLATE.format(version=ver, suffix=suf)
        try:
            resp = requests.get(url, timeout=timeout)
            if resp.status_code == 200:
                df = pd.read_csv(io.StringIO(resp.text))
                if "AssetBundleName" in df.columns:
                    names += df["AssetBundleName"].dropna().tolist()
                if "Size" in df.columns:
                    for n, s in zip(df["AssetBundleName"], df["Size"]):
                        if pd.notna(n) and pd.notna(s):
                            size_map[str(n)] = int(s)
        except Exception:
            continue
    return names, size_map


# ==============================================================================
# 数据表加载与角色元数据索引
# ==============================================================================
def load_monsters_index(master_dir: Path = Path("MasterData")) -> Tuple[Dict[int, Dict[str, Any]], Dict[int, List[Dict[str, Any]]]]:
    """加载 MMonsters.json 并构建 by_id 与 by_sn 双索引"""
    monsters_file = master_dir / "MMonsters.json"
    by_id: Dict[int, Dict[str, Any]] = {}
    by_sn: Dict[int, List[Dict[str, Any]]] = {}

    if not monsters_file.is_file():
        return by_id, by_sn

    try:
        with open(monsters_file, "r", encoding="utf-8") as f:
            data = json.load(f)
            if isinstance(data, list):
                for m in data:
                    cid = m.get("id")
                    if cid is not None:
                        by_id[cid] = m
                    sn = m.get("sn")
                    if sn is not None:
                        by_sn.setdefault(sn, []).append(m)
    except Exception as e:
        console.print(f"[yellow]加载 MMonsters.json 警告: {e}[/yellow]")

    return by_id, by_sn


def resolve_character_info(
    cid_str: str,
    by_id: Dict[int, Dict[str, Any]],
    by_sn: Dict[int, List[Dict[str, Any]]],
) -> Tuple[str, str, List[str]]:
    """
    根据资产编号解析角色名、形态名和备注（CatFantasy 规范）
    返回值：(角色名, 皮肤/形态名, [备注...])
    """
    if cid_str.isdigit():
        cid = int(cid_str)
        # 1. 优先从 MMonsters 精确匹配
        if cid in by_id:
            m = by_id[cid]
            cha_name = m.get("n", "未知角色")
            form_num = cid % 10
            skin_name = f"第{form_num}形态"
            return cha_name, skin_name, [cid_str]

        # 2. 尝试从系列 SN 回溯匹配
        sn_candidate = cid // 10
        if sn_candidate in by_sn and by_sn[sn_candidate]:
            sample = by_sn[sn_candidate][0]
            cha_name = sample.get("n", "未知角色")
            form_num = cid % 10
            skin_name = f"第{form_num}形态"
            return cha_name, skin_name, [cid_str, "特异型"]

    # 3. 兜底回退
    return f"未知角色_{cid_str}", "常规", [cid_str]


# ==============================================================================
# 立绘纹理提取核心
# ==============================================================================
def extract_best_image(bundle_bytes: bytes) -> Tuple[Optional[Image.Image], Optional[str]]:
    """从 UnityBundle 中提取最佳透明立绘图像（优先 Sprite，次选 Texture2D）"""
    dec = decrypt_blob(bundle_bytes) if need_decrypt(bundle_bytes) else bundle_bytes
    if not dec:
        return None, None
    try:
        env = UnityPy.load(dec)
    except Exception:
        return None, None

    # 1. 优先最大的有效 Sprite（透明背景已裁剪优良）
    best_sprite: Optional[Image.Image] = None
    best_sprite_area = 0
    for obj in env.objects:
        if obj.type.name == "Sprite":
            data = obj.read()
            img = getattr(data, "image", None)
            if img:
                area = img.size[0] * img.size[1]
                if area > best_sprite_area:
                    best_sprite_area = area
                    best_sprite = img

    if best_sprite and max(best_sprite.size) >= 150:
        return best_sprite, "sprite"

    # 2. 次选非 Atlas / 非 Dummy 的最大 Texture2D
    best_tex: Optional[Image.Image] = None
    best_tex_area = 0
    for obj in env.objects:
        if obj.type.name == "Texture2D":
            data = obj.read()
            name = getattr(data, "m_Name", getattr(data, "name", "")).lower()
            if "atlas" in name or "dummy" in name:
                continue
            img = getattr(data, "image", None)
            if img:
                area = img.size[0] * img.size[1]
                if area > best_tex_area:
                    best_tex_area = area
                    best_tex = img

    if best_tex and max(best_tex.size) >= 150:
        return best_tex, "texture"

    return best_sprite or best_tex, "fallback"


# ==============================================================================
# 子命令实现
# ==============================================================================
class OtogiFrontierApp:
    def __init__(self, base_dir: Path, jobs: int = DEFAULT_JOBS):
        self.base_dir = base_dir.resolve()
        self.master_dir = self.base_dir / "MasterData"
        self.assets_dir = self.base_dir / "Assets"
        self.painting_dir = self.base_dir / "Painting"
        self.jobs = jobs
        self.session = requests.Session()
        self.session.headers.update({"User-Agent": "OtogiFrontierR/2.0"})

    def _get_version_info(self) -> Dict[str, Any]:
        ver_file = self.base_dir / ".version"
        if ver_file.is_file():
            try:
                return json.loads(ver_file.read_text(encoding="utf-8"))
            except Exception:
                pass
        return {}

    def _save_version_info(self, data: Dict[str, Any]):
        ver_file = self.base_dir / ".version"
        try:
            ver_file.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
        except Exception:
            pass

    # --------------------------------------------------------------------------
    # 子命令：status
    # --------------------------------------------------------------------------
    def run_status(self):
        ver = get_environment_ver()
        tbl = Table(title=f"{GAME_TITLE} (オトギフロンティアR) 状态概览", show_lines=True)
        tbl.add_column("配置项", style="cyan", justify="right")
        tbl.add_column("当前数值", style="green")

        tbl.add_row("游戏名称", f"{GAME_TITLE} (Otogi Frontier R)")
        tbl.add_row("最新线上资源版本", ver)
        tbl.add_row("网关配置接口", "osapi.dmm.com / otogi-sp.trafficmanager.net")
        tbl.add_row("CDN 资产根路径", ASSET_BASE_URL)
        tbl.add_row("数据表下载基址", MASTERDATA_URL)

        local_masters = list(self.master_dir.glob("*.json")) if self.master_dir.exists() else []
        local_assets = [f for f in self.assets_dir.rglob("*") if f.is_file()] if self.assets_dir.exists() else []
        assets_size = sum(f.stat().st_size for f in local_assets) / (1024 * 1024)
        local_paintings = list(self.painting_dir.glob("*.png")) if self.painting_dir.exists() else []
        paint_size = sum(f.stat().st_size for f in local_paintings) / (1024 * 1024)

        tbl.add_row("本地 MasterData", f"{len(local_masters)} 个 JSON 数据表 ({self.master_dir})")
        tbl.add_row("本地 Assets", f"{len(local_assets)} 个文件 ({assets_size:.2f} MB)")
        tbl.add_row("本地 Painting", f"{len(local_paintings)} 张立绘 PNG ({paint_size:.2f} MB)")

        console.print(tbl)

    # --------------------------------------------------------------------------
    # 子命令：version
    # --------------------------------------------------------------------------
    def run_version(self, raw: bool = False):
        ver = get_environment_ver()
        if raw:
            print(ver)
        else:
            console.print(
                Panel.fit(
                    f"[bold green]最新资源版本号:[/bold green] [bold cyan]{ver}[/bold cyan]\n"
                    f"[bold green]CDN 资产根目录:[/bold green] {ASSET_BASE_URL}\n"
                    f"[bold green]MasterData 地址:[/bold green] {MASTERDATA_URL}",
                    title=f"{GAME_TITLE} Version Info",
                )
            )

    # --------------------------------------------------------------------------
    # 子命令：masterdata (别名 data)
    # --------------------------------------------------------------------------
    def run_masterdata(self):
        self.master_dir.mkdir(parents=True, exist_ok=True)
        console.print(f"[*] 正在下载并反序列化 {len(MASTERDATA_FILES)} 个核心数据表...")

        with Progress(
            SpinnerColumn(),
            TextColumn("[cyan]{task.description}"),
            BarColumn(),
            TaskProgressColumn(),
            TimeRemainingColumn(),
            console=console,
        ) as progress:
            task = progress.add_task("下载 MasterData 数据表...", total=len(MASTERDATA_FILES))

            for f_name in MASTERDATA_FILES:
                gz_path = self.master_dir / f_name
                json_path = gz_path.with_suffix(".json")
                try:
                    resp = self.session.get(MASTERDATA_URL + f_name, timeout=DEFAULT_TIMEOUT)
                    resp.raise_for_status()
                    gz_path.write_bytes(resp.content)

                    with gzip.open(gz_path, "rb") as gz_in, open(json_path, "wb") as json_out:
                        shutil.copyfileobj(gz_in, json_out)

                    # 重新格式化输出为规范缩进 JSON
                    with open(json_path, "r", encoding="utf-8") as rf:
                        data = json.load(rf)
                    with open(json_path, "w", encoding="utf-8") as wf:
                        json.dump(data, wf, ensure_ascii=False, indent=2)

                    gz_path.unlink(missing_ok=True)
                except Exception as ex:
                    console.print(f"[red]下载解析 {f_name} 失败: {ex}[/red]")
                finally:
                    progress.advance(task)

        console.print(f"[bold green]√ MasterData 导出完成 -> {self.master_dir}[/bold green]")

    def ensure_masterdata(self, ver: str, force: bool = False):
        """检查并确保 MasterData 数据表为最新"""
        all_exist = all((self.master_dir / f.replace(".gz", ".json")).is_file() for f in MASTERDATA_FILES)
        vinfo = self._get_version_info()
        saved_ver = vinfo.get("masterdata_ver")

        if not force and all_exist and saved_ver == ver:
            console.print(f"[bold green]√ [1/2] MasterData 数据表已就绪且为最新 (版本: v{ver})[/bold green]")
            return

        console.print(f"[*] [1/2] 检查到 MasterData 待更新 (线上版本: v{ver})，正在同步数据表...")
        self.run_masterdata()
        vinfo["masterdata_ver"] = ver
        self._save_version_info(vinfo)

    # --------------------------------------------------------------------------
    # 子命令：assets
    # --------------------------------------------------------------------------
    def run_assets(self, only: str = "all", limit: int = 0):
        self.assets_dir.mkdir(parents=True, exist_ok=True)
        ver = get_environment_ver()
        console.print(f"[*] 正在拉取资源清单 (线上版本: [bold cyan]{ver}[/bold cyan])...")

        webgl_names = download_webgl_manifest(self.base_dir)
        patch_names, size_map = download_patch_list(ver)
        all_assets = sorted(set(webgl_names + patch_names))

        if only.lower() == "chara":
            all_assets = [a for a in all_assets if a.startswith("chara/")]
        elif only.lower() == "stand":
            all_assets = [a for a in all_assets if a.startswith("chara/standimagelarge/")]

        if limit > 0:
            all_assets = all_assets[:limit]

        console.print(f"[*] 待下载/检查资源数: [bold cyan]{len(all_assets)}[/bold cyan] 个")

        stats = {"ok": 0, "skip": 0, "failed": 0}
        lock = threading.Lock()

        def process_asset(rel_path: str):
            save_path = self.assets_dir / rel_path
            expected_size = size_map.get(rel_path)

            if save_path.is_file() and expected_size:
                local_size = save_path.stat().st_size
                if abs(local_size - expected_size) <= 32:
                    with lock:
                        stats["skip"] += 1
                    return

            url = ASSET_BASE_URL + rel_path
            data: Optional[bytes] = None
            for attempt in range(DEFAULT_RETRIES):
                try:
                    resp = self.session.get(url, timeout=DEFAULT_TIMEOUT)
                    if resp.status_code == 200:
                        data = resp.content
                        break
                except Exception:
                    time.sleep(1.0)

            if not data:
                with lock:
                    stats["failed"] += 1
                return

            # AES 解密
            if need_decrypt(data):
                dec = decrypt_blob(data)
                out_data = dec if dec else data
            else:
                out_data = data

            save_path.parent.mkdir(parents=True, exist_ok=True)
            save_path.write_bytes(out_data)
            with lock:
                stats["ok"] += 1

        with Progress(
            SpinnerColumn(),
            TextColumn("[bold cyan]{task.description}"),
            BarColumn(bar_width=32),
            TaskProgressColumn(),
            TimeRemainingColumn(),
            console=console,
        ) as progress:
            task = progress.add_task("下载与解密 Assets...", total=len(all_assets))
            with ThreadPoolExecutor(max_workers=self.jobs) as executor:
                futs = [executor.submit(process_asset, a) for a in all_assets]
                for f in as_completed(futs):
                    f.result()
                    progress.advance(task)

        console.print(
            f"[bold green]√ 资产同步完成:[/bold green] 新增/更新 {stats['ok']}，"
            f"跳过已就绪 {stats['skip']}，失败 {stats['failed']} -> {self.assets_dir}"
        )

    def ensure_standimagelarge_assets(self, ver: str, limit: int = 0) -> List[str]:
        """
        导出立绘前的前置检查：确保 standimagelarge 资产均为最新
        一律只用 standimagelarge，不回退、不混用 stand，并自动下载/解密至 Assets/chara/standimagelarge/
        """
        self.assets_dir.mkdir(parents=True, exist_ok=True)
        webgl_csv = self.base_dir / "WebGL.csv"
        if webgl_csv.is_file():
            try:
                df = pd.read_csv(webgl_csv)
                webgl_names = df["AssetBundleName"].dropna().tolist()
            except Exception:
                webgl_names = download_webgl_manifest(self.base_dir)
        else:
            webgl_names = download_webgl_manifest(self.base_dir)

        patch_names, size_map = download_patch_list(ver)
        all_assets = sorted(set(webgl_names + patch_names))

        # 核心铁律：一律只用 standimagelarge
        large_paths = [a for a in all_assets if a.startswith("chara/standimagelarge/")]
        if limit > 0:
            large_paths = large_paths[:limit]

        need_download: List[str] = []
        for rel_path in large_paths:
            save_path = self.assets_dir / rel_path
            expected_size = size_map.get(rel_path)
            if save_path.is_file():
                sz = save_path.stat().st_size
                if sz > 0:
                    if expected_size and abs(sz - expected_size) <= 32:
                        continue
                    try:
                        with open(save_path, "rb") as f:
                            if f.read(HEAD_LEN) == UNITYFS_MAGIC:
                                continue
                    except Exception:
                        pass
            need_download.append(rel_path)

        if not need_download:
            console.print(
                f"[bold green]√ [2/2] standimagelarge 资产已全部就绪并为最新版本 "
                f"(共 {len(large_paths)} 个包)[/bold green]"
            )
            return large_paths

        console.print(
            f"[*] [2/2] 检测到 [bold cyan]{len(need_download)}[/bold cyan] 个 "
            f"standimagelarge 待更新/下载，正在并发解密同步..."
        )

        stats = {"ok": 0, "failed": 0}
        lock = threading.Lock()

        def sync_one(rel_path: str):
            save_path = self.assets_dir / rel_path
            url = ASSET_BASE_URL + rel_path
            data: Optional[bytes] = None
            for attempt in range(DEFAULT_RETRIES):
                try:
                    resp = self.session.get(url, timeout=DEFAULT_TIMEOUT)
                    if resp.status_code == 200:
                        data = resp.content
                        break
                except Exception:
                    time.sleep(1.0)

            if not data:
                with lock:
                    stats["failed"] += 1
                return

            if need_decrypt(data):
                dec = decrypt_blob(data)
                out_data = dec if dec else data
            else:
                out_data = data

            save_path.parent.mkdir(parents=True, exist_ok=True)
            save_path.write_bytes(out_data)
            with lock:
                stats["ok"] += 1

        with Progress(
            SpinnerColumn(),
            TextColumn("[bold cyan]{task.description}"),
            BarColumn(bar_width=32),
            MofNCompleteColumn(),
            TaskProgressColumn(),
            TimeRemainingColumn(),
            console=console,
        ) as progress:
            task = progress.add_task("增量同步 standimagelarge 资产...", total=len(need_download))
            with ThreadPoolExecutor(max_workers=self.jobs) as executor:
                futs = [executor.submit(sync_one, p) for p in need_download]
                for f in as_completed(futs):
                    f.result()
                    progress.advance(task)

        console.print(
            f"[bold green]√ standimagelarge 资产同步完成:[/bold green] 同步成功 {stats['ok']} 个，"
            f"失败 {stats['failed']} 个"
        )
        return large_paths

    # --------------------------------------------------------------------------
    # 子命令：painting (别名 illust)
    # --------------------------------------------------------------------------
    def run_painting(self, limit: int = 0, force: bool = False):
        """
        导出高清角色大立绘（对齐 CatFantasy 规范：童话边境_角色名_形态X_ID.png）
        核心铁律：
          1. 导出立绘前必须自动检查并确保 MasterData 与 standimagelarge 资产为最新版本
          2. 一律只使用 standimagelarge，不回退、不混用 stand
        """
        self.painting_dir.mkdir(parents=True, exist_ok=True)
        ver = get_environment_ver()
        console.print(f"[*] 正在执行导出前置环境检查 (线上资源版本: [bold cyan]{ver}[/bold cyan])...")

        # 前置检查 1：确保数据表最新
        self.ensure_masterdata(ver)

        # 前置检查 2：确保立绘所需 standimagelarge 资产最新
        large_paths = self.ensure_standimagelarge_assets(ver, limit=limit)

        # 载入角色元数据
        by_id, by_sn = load_monsters_index(self.master_dir)
        console.print(f"[*] 已载入 [bold green]{len(by_id)}[/bold green] 个角色形态元数据")

        console.print(
            f"[*] 准备导出大立绘: [bold cyan]{len(large_paths)}[/bold cyan] 张 "
            f"(来源: [bold green]chara/standimagelarge[/bold green])"
        )

        used_filenames: Set[str] = set()
        jobs_list: List[Tuple[str, Path]] = []

        for asset_path in large_paths:
            cid_str = asset_path.split("/")[-1]
            cha_name, skin_name, notes = resolve_character_info(cid_str, by_id, by_sn)
            fname = painting_filename(cha_name, skin_name, used_filenames, notes)
            dest_path = self.painting_dir / fname
            jobs_list.append((asset_path, dest_path))

        stats = {"written": 0, "skipped": 0, "failed": 0}
        lock = threading.Lock()

        def process_painting(item: Tuple[str, Path]):
            asset_rel, dest_file = item
            if dest_file.is_file() and not force:
                with lock:
                    stats["skipped"] += 1
                return

            local_asset = self.assets_dir / asset_rel
            raw_bytes: Optional[bytes] = None

            if local_asset.is_file():
                raw_bytes = local_asset.read_bytes()
            else:
                # 防御性回退读取
                url = ASSET_BASE_URL + asset_rel
                for _ in range(DEFAULT_RETRIES):
                    try:
                        resp = self.session.get(url, timeout=DEFAULT_TIMEOUT)
                        if resp.status_code == 200:
                            raw_bytes = resp.content
                            break
                    except Exception:
                        time.sleep(1.0)

            if not raw_bytes:
                with lock:
                    stats["failed"] += 1
                return

            img, kind = extract_best_image(raw_bytes)
            if img:
                dest_file.parent.mkdir(parents=True, exist_ok=True)
                img.save(dest_file, "PNG")
                with lock:
                    stats["written"] += 1
            else:
                with lock:
                    stats["failed"] += 1

        with Progress(
            SpinnerColumn(),
            TextColumn("[bold cyan]{task.description}"),
            BarColumn(bar_width=32),
            MofNCompleteColumn(),
            TaskProgressColumn(),
            TimeRemainingColumn(),
            console=console,
        ) as progress:
            task = progress.add_task("导出角色立绘...", total=len(jobs_list))
            with ThreadPoolExecutor(max_workers=self.jobs) as executor:
                futs = [executor.submit(process_painting, j) for j in jobs_list]
                for f in as_completed(futs):
                    f.result()
                    progress.advance(task)

        console.print(
            f"[bold green]√ 立绘导出完成:[/bold green] 成功写出 {stats['written']} 张，"
            f"跳过已有 {stats['skipped']} 张，失败 {stats['failed']} 张 -> {self.painting_dir}"
        )


# ==============================================================================
# CLI 构建与入口
# ==============================================================================
def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help=f"并发线程数 (默认: {DEFAULT_JOBS})")
    shared.add_argument("--output", type=Path, default=Path("."), help="工作区根目录 (默认: 当前目录)")

    parser = argparse.ArgumentParser(
        prog="OtogiFrontierR.py",
        description=f"{GAME_TITLE} (オトギフロンティアR) 综合数据表与资产/立绘提取工具",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "常用命令示例:\n"
            "  python OtogiFrontierR.py status               # 查看远端版本与本地资产状态概览\n"
            "  python OtogiFrontierR.py version              # 查询最新线上 AssetVersion\n"
            "  python OtogiFrontierR.py masterdata           # 下载并解密全部 11 个 JSON 数据表\n"
            "  python OtogiFrontierR.py assets               # 下载/增量更新全量游戏 WebGL 资产\n"
            "  python OtogiFrontierR.py painting             # 导出完整角色大立绘到 Painting/\n"
            "  python OtogiFrontierR.py painting --limit 5   # 测试导出前 5 张立绘\n"
            "  python OtogiFrontierR.py all                  # 一键流水线：版本检查 -> 数据表 -> 立绘\n"
        ),
    )

    sub = parser.add_subparsers(dest="cmd", required=True)

    # status
    sub.add_parser("status", parents=[shared], help="查询服务器与本地版本/数据表/立绘状态看板")

    # version
    v_parser = sub.add_parser("version", parents=[shared], help="探测并输出线上最新版本号")
    v_parser.add_argument("--raw", action="store_true", help="仅输出裸版本号字符串")

    # masterdata (别名 data)
    sub.add_parser("masterdata", aliases=["data"], parents=[shared], help="下载并解密 11 个核心 JSON 数据表")

    # assets
    a_parser = sub.add_parser("assets", parents=[shared], help="下载与 AES 解密 WebGL 资源到 Assets/")
    a_parser.add_argument("--only", default="all", choices=["all", "chara", "stand"], help="指定下载资源范围")
    a_parser.add_argument("--limit", type=int, default=0, help="限制下载数量 (调试用)")

    # painting (别名 illust)
    p_parser = sub.add_parser("painting", aliases=["illust"], parents=[shared], help="提取角色透明全身大立绘 PNG 到 Painting/ (纯净 standimagelarge)")
    p_parser.add_argument("--limit", type=int, default=0, help="只导出前 N 张立绘 (调试用)")
    p_parser.add_argument("-f", "--force", action="store_true", help="覆盖已有 PNG 文件")

    # all
    sub.add_parser("all", parents=[shared], help="一键全流程：检查版本 -> 同步数据表与资产 -> 导出大立绘")

    return parser


def main(argv: Optional[List[str]] = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    app = OtogiFrontierApp(base_dir=args.output, jobs=args.jobs)

    if args.cmd == "status":
        app.run_status()
    elif args.cmd == "version":
        app.run_version(raw=args.raw)
    elif args.cmd in ("masterdata", "data"):
        app.run_masterdata()
    elif args.cmd == "assets":
        app.run_assets(only=args.only, limit=args.limit)
    elif args.cmd in ("painting", "illust"):
        app.run_painting(limit=args.limit, force=args.force)
    elif args.cmd == "all":
        console.print("[bold cyan]=== [1/2] 检查版本状态 ===[/bold cyan]")
        app.run_status()
        console.print("\n[bold cyan]=== [2/2] 导出角色大立绘 (自动前置同步数据表与资产) ===[/bold cyan]")
        app.run_painting(limit=0)
        console.print("\n[bold green]√ 全部流程执行完毕！[/bold green]")
    else:
        parser.print_help()

    return 0


if __name__ == "__main__":
    sys.exit(main())
