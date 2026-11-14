from __future__ import annotations

"""反向蓝数据表（GetMasterData / msgpack）解析与落盘。

接口响应为纯 msgpack map：841 张 list 表 + 77 个标量配置（AppStatusCode/
CatalogVersion/MasterDataModifiedTime 等）。数据表按 <Table>.json（indent=2）
写入 MasterData/，标量汇总为 _scalars.json，另写 _catalog.json/_meta.json。
"""

import json
import shutil
from datetime import date, datetime
from pathlib import Path
from typing import Any

import msgpack

META_KEYS = (
    "AppStatusCode",
    "AppMessage",
    "CatalogVersion",
    "InfoBars",
    "CheckCatalogVersion",
    "MasterDataModifiedTime",
    "CurrentServerTime",
)

CONFIG_FILES = (
    "bin/Data/boot.config",
    "bin/Data/RuntimeInitializeOnLoads.json",
    "bin/Data/ScriptingAssemblies.json",
    "UnityServicesProjectConfiguration.json",
    "google-services-desktop.json",
    "aa/settings.json",
    "aa/catalog.json",
)


def _ext_hook(code: int, data: bytes) -> Any:
    return {"__ext__": code, "hex": data.hex()}


def unpack(payload: bytes) -> dict[str, Any]:
    data = msgpack.unpackb(
        payload,
        raw=False,
        strict_map_key=False,
        ext_hook=_ext_hook,
    )
    if not isinstance(data, dict):
        raise RuntimeError(f"masterdata 顶层应为 map，实际 {type(data)!r}")
    return data


def split_tables(data: dict[str, Any]) -> tuple[dict[str, list[Any]], dict[str, Any]]:
    tables: dict[str, list[Any]] = {}
    scalars: dict[str, Any] = {}
    for name, value in data.items():
        if isinstance(value, list):
            tables[name] = value
        else:
            scalars[name] = value
    return tables, scalars


def json_default(value: Any) -> Any:
    if isinstance(value, (bytes, bytearray)):
        try:
            return value.decode("utf-8")
        except UnicodeDecodeError:
            return value.hex()
    if isinstance(value, msgpack.Timestamp):
        return value.to_datetime().isoformat()
    if isinstance(value, (datetime, date)):
        return value.isoformat()
    raise TypeError(f"无法序列化的类型 {type(value)!r}")


def write_json(path: Path, obj: Any, *, indent: int = 2) -> Path:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        json.dumps(obj, ensure_ascii=False, indent=indent, default=json_default),
        encoding="utf-8",
    )
    return path


def write_tables(
    tables: dict[str, list[Any]],
    out_dir: Path,
    *,
    indent: int = 2,
    on_table: Any | None = None,
) -> int:
    out_dir.mkdir(parents=True, exist_ok=True)
    written = 0
    for name, rows in tables.items():
        dest = write_json(out_dir / f"{name}.json", rows, indent=indent)
        written += 1
        if on_table is not None:
            on_table(name, dest, len(rows))
    return written


def write_scalars(scalars: dict[str, Any], dest: Path, *, indent: int = 2) -> Path:
    return write_json(dest, scalars, indent=indent)


def write_catalog(tables: dict[str, list[Any]], dest: Path, *, indent: int = 2) -> Path:
    catalog = {
        name: {"count": len(rows), "file": f"{name}.json"}
        for name, rows in sorted(tables.items())
    }
    return write_json(dest, catalog, indent=indent)


def write_meta(scalars: dict[str, Any], dest: Path, *, indent: int = 2) -> Path:
    return write_json(dest, {key: scalars[key] for key in META_KEYS if key in scalars}, indent=indent)


def copy_configs(assets_dir: Path, master_dir: Path) -> int:
    """把 Assets/ 里的 Unity / Addressables / 客户端配置复制进 MasterData/Config。"""
    config_dir = master_dir / "Config"
    copied = 0
    for relative in CONFIG_FILES:
        src = assets_dir / relative
        if not src.is_file():
            continue
        dest = config_dir / Path(relative).name
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dest)
        copied += 1
    return copied


def copy_catalog_artifacts(assets_dir: Path, master_dir: Path) -> int:
    """把 Assets/Catalog/ 的 catalog 解析结果复制进 MasterData/Config。"""
    catalog_dir = assets_dir / "Catalog"
    if not catalog_dir.is_dir():
        return 0
    config_dir = master_dir / "Config"
    config_dir.mkdir(parents=True, exist_ok=True)
    copied = 0
    for src_name, dest_name in (
        ("manifest.json", "Manifest.json"),
        ("local_addressables.json", "LocalAddressables.json"),
    ):
        src = catalog_dir / src_name
        if src.is_file():
            shutil.copy2(src, config_dir / dest_name)
            copied += 1
    aura = sorted(catalog_dir.glob("*.catalog.json"))
    if aura:
        shutil.copy2(aura[0], config_dir / "AuraCatalog.json")
        copied += 1
    return copied
