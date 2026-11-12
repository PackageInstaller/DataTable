from __future__ import annotations

import os
import struct
import subprocess
import tempfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

from rich.console import Console
from rich.progress import Progress

from StellaArchive import StellaArchive


def extract_lua_source_path(data: bytes) -> str | None:
    if not data.startswith(b"\x1bLua"):
        return None
    try:
        pos = 34
        if len(data) <= pos:
            return None
        tag = data[pos]
        if tag < 0xFF:
            slen = tag
            spos = pos + 1
        else:
            slen = struct.unpack_from("<Q", data, pos + 1)[0]
            spos = pos + 9

        if len(data) < spos + slen - 1:
            return None

        raw_src = data[spos : spos + slen - 1].decode("utf-8", "ignore")
        if raw_src.startswith("@"):
            raw_src = raw_src[1:]
        raw_src = raw_src.replace("\\", "/")

        if "/Nova_Client/Lua/" in raw_src:
            raw_src = raw_src.split("/Nova_Client/Lua/", 1)[-1]
        elif "/Lua/" in raw_src:
            raw_src = raw_src.split("/Lua/", 1)[-1]
        elif ":/" in raw_src:
            raw_src = raw_src.split(":/", 1)[-1].lstrip("/")

        return raw_src.strip("/")
    except Exception:
        return None


def _decompile_worker(item: tuple[bytes, Path, Path, bool]) -> tuple[bool, str, str]:
    bytecode, target_lua, temp_luac, force = item
    if target_lua.exists() and not force:
        return (True, target_lua.name, "skipped")

    target_lua.parent.mkdir(parents=True, exist_ok=True)
    temp_luac.parent.mkdir(parents=True, exist_ok=True)

    try:
        temp_luac.write_bytes(bytecode)
        proc = subprocess.run(
            ["unluac", "--rawstring", str(temp_luac), "--output", str(target_lua)],
            capture_output=True,
            text=True,
            timeout=30,
        )
        if proc.returncode != 0:
            err_msg = proc.stderr.strip() or f"unluac exit {proc.returncode}"
            fallback_luac = target_lua.with_suffix(".luac")
            fallback_luac.write_bytes(bytecode)
            return (False, target_lua.name, err_msg)
        return (True, target_lua.name, "ok")
    except Exception as ex:
        fallback_luac = target_lua.with_suffix(".luac")
        fallback_luac.write_bytes(bytecode)
        return (False, target_lua.name, str(ex))
    finally:
        if temp_luac.exists():
            try:
                temp_luac.unlink()
            except OSError:
                pass


def export_lua_all(
    archive: StellaArchive,
    output_dir: Path,
    jobs: int = 16,
    force: bool = False,
    console: Console | None = None,
    progress: Progress | None = None,
) -> tuple[int, int, int]:
    output_dir.mkdir(parents=True, exist_ok=True)
    temp_root = Path(tempfile.gettempdir()) / "stellasora_lua_tmp"
    temp_root.mkdir(parents=True, exist_ok=True)

    tasks_to_decompile: list[tuple[bytes, Path, Path, bool]] = []
    other_saved = 0

    for i, entry in enumerate(archive.entries):
        data = archive.read_entry(entry, decrypt=True)
        if data.startswith(b"\x1bLua"):
            rel_path = extract_lua_source_path(data)
            if not rel_path:
                rel_path = f"Unknown/chunk_{hex(entry.hash)}.lua"
            target_path = output_dir / rel_path
            temp_luac = temp_root / f"tmp_{os.getpid()}_{i}_{hex(entry.hash)}.luac"
            tasks_to_decompile.append((data, target_path, temp_luac, force))
        else:
            if b"client_table.proto" in data:
                pb_path = output_dir.parent / "table.pb"
                pb_path.write_bytes(data)
                other_saved += 1
            elif b".proto" in data[:64]:
                proto_dir = output_dir.parent / "Protobuf"
                proto_dir.mkdir(parents=True, exist_ok=True)
                (proto_dir / f"descriptor_{hex(entry.hash)}.pb").write_bytes(data)
                other_saved += 1

    total_tasks = len(tasks_to_decompile)
    prog_task = None
    if progress is not None:
        prog_task = progress.add_task("[cyan]反编译 Lua 脚本...", total=total_tasks)

    ok_count = 0
    skip_count = 0
    fail_count = 0

    with ThreadPoolExecutor(max_workers=jobs) as executor:
        futures = [executor.submit(_decompile_worker, item) for item in tasks_to_decompile]
        for fut in as_completed(futures):
            success, name, status = fut.result()
            if success:
                if status == "skipped":
                    skip_count += 1
                else:
                    ok_count += 1
            else:
                fail_count += 1
                if console:
                    console.print(f"[yellow]反编译警告[/yellow] {name}: {status}")

            if progress is not None and prog_task is not None:
                progress.advance(prog_task)

    try:
        temp_root.rmdir()
    except OSError:
        pass

    return (ok_count, skip_count, fail_count)
