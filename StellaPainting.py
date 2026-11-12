from __future__ import annotations

import json
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any

import UnityPy
from PIL import Image
from rich.console import Console
from rich.progress import (
    Progress
)

GAME_TITLE = "星塔旅人"
PAINTING_DIR_NAME = "Painting"
_SAFE = str.maketrans({c: "＿" for c in '\\/:*?"<>|'})

BODY_SUFFIX = "001"
FACE_SUFFIX = "002"


def _safe(text: str) -> str:
    return (text or "").translate(_SAFE).strip() or "未知"


def load_character_tables(tables_dir: Path) -> tuple[dict[str, Any], dict[str, Any]]:
    char_map: dict[str, Any] = {}
    skin_map: dict[str, Any] = {}
    char_file = tables_dir / "Character.json"
    skin_file = tables_dir / "CharacterSkin.json"
    if char_file.is_file():
        try:
            char_map = json.loads(char_file.read_text(encoding="utf-8"))
        except Exception:
            char_map = {}
    if skin_file.is_file():
        try:
            skin_map = json.loads(skin_file.read_text(encoding="utf-8"))
        except Exception:
            skin_map = {}
    return char_map, skin_map


def sprite_render_offset(sprite_obj: Any) -> tuple[float, float] | None:
    tt = sprite_obj.read_typetree()
    atlas_ptr = tt.get("m_SpriteAtlas") or {}
    if atlas_ptr.get("m_PathID"):
        atlas_obj = sprite_obj.assets_file.objects[atlas_ptr["m_PathID"]]
        atlas_tt = atlas_obj.read_typetree()
        key = tt.get("m_RenderDataKey")
        for k, v in atlas_tt.get("m_RenderDataMap", []):
            if k[0] == key[0] and k[1] == key[1]:
                off = v.get("textureRectOffset")
                if off:
                    return float(off["x"]), float(off["y"])
        return None
    rd = tt.get("m_RD") or {}
    off = rd.get("textureRectOffset")
    if off:
        return float(off["x"]), float(off["y"])
    return None


def compose_painting(bundle_path: Path) -> tuple[Image.Image, dict[str, Any]]:
    env = UnityPy.load(str(bundle_path))
    skin_id = bundle_path.stem
    sprites: dict[str, tuple[Any, Any]] = {}
    for obj in env.objects:
        if obj.type.name != "Sprite":
            continue
        try:
            data = obj.read()
        except Exception:
            continue
        sprites.setdefault(data.m_Name, (obj, data))

    body_name = f"{skin_id}_{BODY_SUFFIX}"
    face_name = f"{skin_id}_{FACE_SUFFIX}"
    _, body = sprites[body_name]
    width = int(round(body.m_Rect.width))
    height = int(round(body.m_Rect.height))
    canvas = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    meta: dict[str, Any] = {"skin_id": skin_id, "canvas": [width, height], "layers": []}

    for name in (body_name, face_name):
        if name not in sprites:
            continue
        sprite_obj, sprite = sprites[name]
        offset = sprite_render_offset(sprite_obj)
        layer = sprite.image.convert("RGBA")
        x = int(round(offset[0]))
        y = int(round(height - offset[1] - layer.height))
        canvas.alpha_composite(layer, (x, y))
        meta["layers"].append({"name": name, "image": [layer.width, layer.height], "pos": [x, y]})

    return canvas, meta


def plan_paintings(
    char2d_dir: Path,
    output_dir: Path,
    char_map: dict[str, Any],
    skin_map: dict[str, Any],
) -> list[dict[str, Any]]:
    plans: list[dict[str, Any]] = []
    used: set[Path] = set()
    for bundle_path in sorted(char2d_dir.glob("*.unity3d")):
        skin_id = bundle_path.stem
        entry = skin_map.get(skin_id)
        if isinstance(entry, dict):
            char_id = str(entry.get("CharId") or "")
            char_info = char_map.get(char_id) or {}
            char_name = (char_info.get("Name") or "").strip() or char_id or skin_id
            skin_name = (entry.get("Name") or "").strip() or skin_id
            skin_type = entry.get("Type")
            file_stem = f"{GAME_TITLE}_{char_name}" if skin_type == 1 else f"{GAME_TITLE}_{skin_name}"
            out_path = output_dir / _safe(char_name) / f"{_safe(file_stem)}.png"
        else:
            out_path = output_dir / _safe(skin_id) / f"{GAME_TITLE}_{skin_id}.png"

        if out_path in used:
            out_path = out_path.with_name(f"{out_path.stem}_{skin_id}.png")
        used.add(out_path)
        plans.append({"bundle": bundle_path, "out": out_path, "skin_id": skin_id})
    return plans


def export_paintings_all(
    char2d_dir: Path,
    output_dir: Path,
    tables_dir: Path,
    force: bool = False,
    jobs: int = 8,
    console: Console | None = None,
    progress: Progress | None = None,
) -> tuple[int, int, int]:
    char_map, skin_map = load_character_tables(tables_dir)
    plans = plan_paintings(char2d_dir, output_dir, char_map, skin_map)

    output_dir.mkdir(parents=True, exist_ok=True)
    prog_task = None
    if progress is not None:
        prog_task = progress.add_task("[cyan]导出角色立绘...", total=len(plans))

    ok_count = skip_count = fail_count = 0

    def _one(plan: dict[str, Any]) -> tuple[bool, bool, str, str]:
        out_path: Path = plan["out"]
        if out_path.exists() and not force:
            return (True, True, plan["skin_id"], "")
        try:
            out_path.parent.mkdir(parents=True, exist_ok=True)
            image, _meta = compose_painting(plan["bundle"])
            image.save(out_path)
            return (True, False, plan["skin_id"], str(out_path))
        except Exception as ex:
            return (False, False, plan["skin_id"], f"{type(ex).__name__}: {ex}")

    with ThreadPoolExecutor(max_workers=max(1, min(jobs, 16))) as executor:
        futures = [executor.submit(_one, plan) for plan in plans]
        for fut in as_completed(futures):
            good, skipped, skin_id, info = fut.result()
            if good and skipped:
                skip_count += 1
            elif good:
                ok_count += 1
            else:
                fail_count += 1
                if console:
                    console.print(f"[yellow]立绘导出失败[/yellow] {skin_id}: {info}")
            if progress is not None and prog_task is not None:
                progress.advance(prog_task)

    return (ok_count, skip_count, fail_count)
