from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

import rebuild_all_dlls as R

ROOT = Path(__file__).resolve().parent.parent  # AetherGazer 仓库根
WS = ROOT.parent  # 当前工作区根（TextAsset / dll 引用所在）


def rebuild_to(dll_dir: Path, textasset_dir: Path) -> int:
    dll_dir.mkdir(parents=True, exist_ok=True)
    ok = fail = 0
    for path in sorted(textasset_dir.glob("*.bytes")):
        if path.read_bytes()[:4] != b"CDPH":
            continue
        try:
            res = R.rebuild_one(path)
        except Exception as exc:  # noqa: BLE001
            print(f"[!] 重建失败 {path.name}: {exc}")
            fail += 1
            continue
        if res is None:
            fail += 1
            continue
        data, name = res
        (dll_dir / name).write_bytes(data)
        print(f"[*] 重建 {path.name} -> {name}")
        ok += 1
    print(f"[*] 重建完成：成功 {ok}，失败 {fail} -> {dll_dir}")
    return fail


def decompile_one(
    dll: Path, refs: Path, dll_dir: Path, ilspycmd: str, force: bool
) -> tuple[str, bool, str]:
    name = dll.stem
    target = dll_dir / name
    if not force and target.is_dir():
        ncs = sum(1 for _ in target.rglob("*.cs"))
        if ncs:
            return name, True, f"跳过（已有 {ncs} 个 .cs）"
    if target.exists():
        shutil.rmtree(target, ignore_errors=True)
    target.mkdir(parents=True)
    proc = subprocess.run(
        [ilspycmd, "-p", str(refs / dll.name), "-o", str(target)],
        capture_output=True, text=True, timeout=1800,
    )
    ncs = sum(1 for _ in target.rglob("*.cs"))
    if proc.returncode != 0:
        err = (proc.stderr or proc.stdout or "").strip().splitlines()
        return name, False, (err[-1] if err else f"exit {proc.returncode}")
    return name, True, f"{ncs} 个 .cs"


def main() -> int:
    ap = argparse.ArgumentParser(description="重建并反编译全部热更 DLL")
    ap.add_argument("--textasset", default=str(WS / "TextAsset"),
                    help="TextAsset 目录（默认 <工作区>/TextAsset）")
    ap.add_argument("--jobs", type=int, default=8, help="反编译并发数")
    ap.add_argument("--ilspycmd", default="ilspycmd", help="ilspycmd 路径")
    ap.add_argument("--force", action="store_true", help="强制重新反编译")
    args = ap.parse_args()

    textasset = Path(args.textasset)
    dll_dir = ROOT / "DLL"
    ref_dir = WS / "dll"
    if not textasset.is_dir():
        print(f"[!] TextAsset 目录不存在: {textasset}", file=sys.stderr)
        return 2

    if rebuild_to(dll_dir, textasset):
        print("[!] 存在重建失败，继续尝试反编译已成功的 DLL", file=sys.stderr)

    dlls = sorted(p for p in dll_dir.glob("*.dll"))
    if not dlls:
        print("[!] 没有可反编译的 DLL", file=sys.stderr)
        return 1

    with tempfile.TemporaryDirectory(prefix="ag_decompile_") as tmp:
        refs = Path(tmp) / "ref"
        refs.mkdir()
        for src in (ref_dir, dll_dir):
            for f in src.glob("*.dll"):
                shutil.copy2(f, refs / f.name)
        print(f"[*] 反编译 {len(dlls)} 个 DLL -> {dll_dir}（并发 {args.jobs}）")
        ok = fail = 0
        failures = []
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futs = {
                pool.submit(
                    decompile_one, d, refs, dll_dir, args.ilspycmd, args.force
                ): d
                for d in dlls
            }
            for fut in as_completed(futs):
                name, success, msg = fut.result()
                if success:
                    ok += 1
                    print(f"[+] {name}: {msg}")
                else:
                    fail += 1
                    failures.append((name, msg))
                    print(f"[-] {name}: {msg}", file=sys.stderr)
    print(f"[*] 反编译完成：成功 {ok}，失败 {fail}")
    if failures:
        log = dll_dir / "decompile_errors.log"
        log.write_text(
            "\n".join(f"{n}\t{e}" for n, e in failures), encoding="utf-8"
        )
        print(f"[!] 失败明细 -> {log}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
