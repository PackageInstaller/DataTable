from __future__ import annotations

import argparse
import hashlib
import json
import shutil
import struct
import subprocess
import sys
import urllib.error
import urllib.request
from pathlib import Path

import UnityPy

SCRIPT_DIR = Path(__file__).resolve().parent

DEFAULT_BASE_URL = (
    "http://cove-1317257923.cos.ap-shanghai.myqcloud.com/coveopenbeta/res/channel1_new"
)
GITHUB_YOOASSET_REPO = "https://github.com/PackageInstaller/Script.git"
DEFAULT_YOO_DIR = Path("/home/rikka/Script/YooAsset")

SCRIPT_BUNDLE_PREFIX = "assets_pack_script_"
SCRIPT_BUNDLE_SUFFIX = ".bundle"


# DcmDLL::cctor
DEFAULT_CUSTOM_KEY = bytes.fromhex(
    "816bf77333a9c88defc66a59aea588bc89b1b28d39e16ccba0ca26d8ca0c7cc9"
    "bcfdcf7a7aaaafa183299a722d9bc2737ddb9d7c0938cd60acfea87b98ccceaf"
    "ac3ceaecdb82cd55c5"
)

ENCRYPT_START_HEX = (
    "c96b7dfa5947f0d5a2f8982169d9b7fd93ad0e355726363ff7cca5e5f17104c7"
    "2324c31896059a1280e5eb27b28309832c271a1b6e55a03bd6b329e32f858ca1"
    "89520dbfe64268992d0fb054bb16d1efaa41fb434d3385f9027f503c9fa851a3"
    "40458f01929d38f5b6da2110fff3cd0c13bcec5f972417a77e4d645d19736081"
    "4fc4dc522a9088eeb814de5e0bdb70a6b4c6dd743eb54666cf9ca472c148"
)
KEY256_HEX = (
    "657c777bf26b6fc5672bfed7ab76e8d257d10032ed20fcb15bcbbe394a4c38cf"
    "c182c96a7dfa5947f0d4a2f8981169d9b7fd93ad0e355726364ff7cca5e5f171"
    "04c72334c31896059a1280e2eb27b27509832c071a1b6e5aa03bd6b329e32f84"
    "8da189520dbfe64268992d0fb054bb16d0efaa41fb434d3385f9027f503c9fa8"
    "51a340458f21929d38f6b6da2110fff3cd0c23bcec5f974417a77e3d645d1973"
    "60814fc4dc222a9088eeb814de5e0bdb72a6b4c6dd743eb54666af9ca472c048"
    "e0323a610a4906245cd3ac629195e479e9c837c26d5dd54ea956f4ea657aae08"
    "ba78256c2e1c1f4bbd8b8a03f6b986c1e18e941e87e9ce5528df9b1d9ed83315"
)

HEADER_LEN = 158  # 0x9E


class Elf64:
    def __init__(self, blob: bytes):
        if blob[:4] != b"\x7fELF" or blob[4] != 2:
            raise ValueError("not an ELF64 file")
        self.data = blob
        self.shoff = struct.unpack_from("<Q", blob, 0x28)[0]
        self.shentsize = struct.unpack_from("<H", blob, 0x3A)[0]
        self.shnum = struct.unpack_from("<H", blob, 0x3C)[0]
        self.shstrndx = struct.unpack_from("<H", blob, 0x3E)[0]
        self.sections = [self._section(i) for i in range(self.shnum)]

    def _section(self, idx: int):
        off = self.shoff + idx * self.shentsize
        b = self.data
        return {
            "name_off": struct.unpack_from("<I", b, off)[0],
            "type": struct.unpack_from("<I", b, off + 4)[0],
            "addr": struct.unpack_from("<Q", b, off + 0x10)[0],
            "offset": struct.unpack_from("<Q", b, off + 0x18)[0],
            "size": struct.unpack_from("<Q", b, off + 0x20)[0],
            "link": struct.unpack_from("<I", b, off + 0x28)[0],
            "entsize": struct.unpack_from("<Q", b, off + 0x38)[0],
        }

    def _name(self, section, strtab):
        start = strtab["offset"] + section["name_off"]
        end = self.data.index(b"\0", start)
        return self.data[start:end].decode()

    def symbol(self, name: str):
        strtab = None
        dynsym = None
        for sec in self.sections:
            sec_name = (
                self._name(sec, self.sections[self.shstrndx]) if self.sections else ""
            )
            if sec["type"] == 3 and sec_name == ".dynstr":
                strtab = sec
            if sec["type"] == 11 and sec_name == ".dynsym":
                dynsym = sec
        if dynsym is None or strtab is None:
            raise ValueError("no .dynsym/.dynstr")
        entsize = dynsym["entsize"] or 24
        for i in range(dynsym["size"] // entsize):
            off = dynsym["offset"] + i * entsize
            st_name = struct.unpack_from("<I", self.data, off)[0]
            st_shndx = struct.unpack_from("<H", self.data, off + 6)[0]
            st_value = struct.unpack_from("<Q", self.data, off + 8)[0]
            st_size = struct.unpack_from("<Q", self.data, off + 16)[0]
            if not st_name:
                continue
            start = strtab["offset"] + st_name
            end = self.data.index(b"\0", start)
            sym_name = self.data[start:end].decode()
            if sym_name == name:
                sec = self.sections[st_shndx]
                file_off = st_value - sec["addr"] + sec["offset"]
                return self.data[file_off : file_off + st_size]
        raise ValueError(f"symbol {name!r} not found")


def decrypt_one(
    data: bytes, encrypt_start: bytes, key: bytes, custom_key: bytes
) -> bytes:
    if len(data) < HEADER_LEN + 1:
        return data
    for i in range(157):
        if data[i] != encrypt_start[i] ^ custom_key[i % len(custom_key)]:
            return data  # not the expected encrypted format
    n = len(data) - HEADER_LEN
    out = bytearray(n)
    for i in range(n):
        out[i] = (
            data[HEADER_LEN + i]
            ^ key[i & 0xFF]
            ^ custom_key[(i & 0xFF) % len(custom_key)]
        )
    return bytes(out)


def looks_like_lua(data: bytes) -> bool:
    head = data[:64].lower()
    return head.startswith(b"\x1blua") or any(
        token in head
        for token in (
            b"local",
            b"function",
            b"return",
            b"require",
            b"--",
            b"module",
            b"table",
        )
    )


def http_get(url: str, timeout: int = 30) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return resp.read()


def ensure_yooasset(yoo_dir: Path, update: bool = False) -> None:
    yooasset_pkg = yoo_dir / "yooasset"
    if not (yooasset_pkg / "__init__.py").exists():
        print(f"[yooasset] 未找到本地库，从云端克隆: {GITHUB_YOOASSET_REPO}")
        yoo_dir.parent.mkdir(parents=True, exist_ok=True)
        if yoo_dir.exists() and any(yoo_dir.iterdir()):
            raise SystemExit(f"{yoo_dir} 已存在且不为空，无法自动克隆，请手动处理")
        subprocess.run(
            ["git", "clone", "--depth", "1", GITHUB_YOOASSET_REPO, str(yoo_dir)],
            check=True,
        )
    elif update:
        print(f"[yooasset] 更新云端脚本: {yoo_dir}")
        subprocess.run(["git", "-C", str(yoo_dir), "pull", "--ff-only"], check=False)

    sys.path.insert(0, str(yoo_dir))
    try:
        from yooasset.deserializer import ManifestDeserializer  # noqa: F401
    except ImportError as e:
        raise SystemExit(f"导入云端 YooAsset 库失败: {e}")


def remote_version(base_url: str) -> str:
    data = json.loads(http_get(f"{base_url}/version_Android.txt").decode("utf-8"))
    return f"{data['version']}.{data['resVer2']}"


def parse_manifest(data: bytes):
    from yooasset.deserializer import ManifestDeserializer

    manifest = ManifestDeserializer(data).deserialize()
    bundles = {b.bundle_name: b for b in manifest.bundle_list}
    return manifest, bundles


def version_tuple(ver: str):
    return tuple(int(x) for x in ver.split("."))


def local_version(work_dir: Path, yoo_dir: Path | None = None) -> str | None:
    state = work_dir / "current_version.txt"
    if state.exists():
        return state.read_text().strip()
    manifests = sorted((work_dir / "manifests").glob("packageScript_*.bytes"))
    if manifests:
        return manifests[-1].name[len("packageScript_") : -len(".bytes")]
    if yoo_dir is not None:
        info = (
            yoo_dir
            / "Update"
            / "assets"
            / "Assets"
            / "Pack_Version"
            / "versionInfo.json"
        )
        if info.exists():
            return json.loads(info.read_text(encoding="utf-8")).get("Version")
    return None


def script_bundles(bundles: dict) -> list:
    return [
        b
        for name, b in bundles.items()
        if name.startswith(SCRIPT_BUNDLE_PREFIX) and name.endswith(SCRIPT_BUNDLE_SUFFIX)
    ]


def find_existing_bundle(
    work_dir: Path,
    bundle,
    yoo_dir: Path | None = None,
) -> Path | None:
    """在 HotUpdate/bundles 中寻找匹配的 bundle；yoo_dir 旧缓存仅在显式启用时使用。"""
    candidates = [
        work_dir / "bundles" / bundle.bundle_name,
    ]
    if yoo_dir is not None:
        subdir = bundle.bundle_name[
            len(SCRIPT_BUNDLE_PREFIX) : -len(SCRIPT_BUNDLE_SUFFIX)
        ]
        candidates += [
            yoo_dir / "Update" / "assets" / "pack" / "script" / f"{subdir}.bundle",
            yoo_dir
            / "yoo"
            / "packageScript"
            / "BundleFiles"
            / bundle.file_hash
            / "__data",
        ]
    for path in candidates:
        if not path.is_file():
            continue
        if path.stat().st_size != bundle.file_size:
            continue
        if hashlib.md5(path.read_bytes()).hexdigest() != bundle.file_hash:
            continue
        return path
    return None


def fetch_version_info(
    base_url: str, version: str, work_dir: Path, force: bool = False
) -> dict:
    """下载 assets_pack_version.bundle 并解析出每个 bundle 自己的版本号。"""
    dest_dir = work_dir / "versionInfo"
    dest_dir.mkdir(parents=True, exist_ok=True)
    dest = dest_dir / f"assets_pack_version_{version}.bundle"
    url = f"{base_url}/{version}/Android/Version/assets_pack_version.bundle"
    if not dest.exists() or force:
        print(f"[versionInfo] 下载 {url}")
        dest.write_bytes(http_get(url, timeout=60))

    env = UnityPy.load(str(dest))
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        data = obj.read()
        if data.m_Name != "versionInfo":
            continue
        raw = data.m_Script
        if isinstance(raw, bytes):
            raw = raw.decode("utf-8", errors="replace")
        info = json.loads(raw)
        return {item["BundleName"]: item["Version"] for item in info["BundleVersions"]}
    raise SystemExit("versionInfo 未在 assets_pack_version.bundle 中找到")


def download_bundle(base_url: str, bundle_version: str, bundle, work_dir: Path) -> Path:
    dest_dir = work_dir / "bundles"
    dest_dir.mkdir(parents=True, exist_ok=True)
    dest = dest_dir / bundle.bundle_name
    url = f"{base_url}/{bundle_version}/Android/Script/{bundle.bundle_name}"
    print(f"[download] {bundle.bundle_name} ({bundle.file_size} bytes) <- {url}")
    data = http_get(url, timeout=120)
    if len(data) != bundle.file_size:
        raise SystemExit(
            f"{bundle.bundle_name}: 大小不符 (期望 {bundle.file_size}, 实际 {len(data)})"
        )
    if hashlib.md5(data).hexdigest() != bundle.file_hash:
        raise SystemExit(f"{bundle.bundle_name}: MD5 校验失败")
    dest.write_bytes(data)
    return dest


def extract_bundle(bundle_path: Path, bundle_name: str, assets_dir: Path) -> list[Path]:
    """把 AssetBundle 里的 TextAsset 提成加密 Lua 文件。"""
    subdir = bundle_name[len(SCRIPT_BUNDLE_PREFIX) : -len(SCRIPT_BUNDLE_SUFFIX)]
    out_dir = assets_dir / subdir
    out_dir.mkdir(parents=True, exist_ok=True)

    env = UnityPy.load(str(bundle_path))
    written: list[Path] = []
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        data = obj.read()
        name = data.m_Name
        if not name or not name.lower().endswith((".lua", ".pb")):
            continue
        raw = data.m_Script
        if isinstance(raw, str):
            raw = raw.encode("utf-8", errors="surrogateescape")
        rel = Path(*name.replace("\\", "/").split("/"))
        dst = out_dir / rel
        dst.parent.mkdir(parents=True, exist_ok=True)
        dst.write_bytes(raw)
        written.append(dst.relative_to(assets_dir))
    return written


def decrypt_paths(
    rel_paths: list[Path],
    assets_dir: Path,
    master_dir: Path,
    encrypt_start: bytes,
    key: bytes,
    custom_key: bytes,
) -> tuple[int, int]:
    decrypted = unchanged = 0
    for rel in rel_paths:
        src = assets_dir / rel
        raw = src.read_bytes()
        out = decrypt_one(raw, encrypt_start, key, custom_key)
        dst = master_dir / rel
        dst.parent.mkdir(parents=True, exist_ok=True)
        dst.write_bytes(out)
        if out == raw:
            unchanged += 1
        else:
            decrypted += 1
    return decrypted, unchanged


def decrypt_tree(
    input_dir: Path,
    output_dir: Path,
    encrypt_start: bytes,
    key: bytes,
    custom_key: bytes,
    exts: list[str],
) -> tuple[int, int, int, int]:
    """整目录解密（--decrypt-only 模式）。"""
    files = sorted(
        p
        for p in input_dir.rglob("*")
        if p.is_file() and p.suffix.lower() in {e.lower() for e in exts}
    )
    decrypted = unchanged = suspicious = 0
    for src in files:
        raw = src.read_bytes()
        out = decrypt_one(raw, encrypt_start, key, custom_key)
        rel = src.relative_to(input_dir)
        dst = output_dir / rel
        dst.parent.mkdir(parents=True, exist_ok=True)
        if out == raw:
            unchanged += 1
        elif not looks_like_lua(out):
            suspicious += 1
            print(f"[?] {rel}: decrypted but output doesn't look like Lua")
        else:
            decrypted += 1
        dst.write_bytes(out)
    return len(files), decrypted, unchanged, suspicious


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--base-url", default=DEFAULT_BASE_URL)
    ap.add_argument("--yoo-dir", default=DEFAULT_YOO_DIR, type=Path)
    ap.add_argument("--work-dir", default=SCRIPT_DIR / "HotUpdate", type=Path)
    ap.add_argument(
        "--assets-dir", default=SCRIPT_DIR / "Assets" / "Pack_Script", type=Path
    )
    ap.add_argument("--master-dir", default=SCRIPT_DIR / "MasterData", type=Path)
    ap.add_argument("--key-hex", default=None)
    ap.add_argument(
        "--decrypt-only",
        action="store_true",
        help="只解密本地 Assets/Pack_Script -> MasterData",
    )
    ap.add_argument(
        "--ext",
        nargs="*",
        default=[".lua", ".pb"],
        help="--decrypt-only 时处理的扩展名",
    )
    ap.add_argument("--force", action="store_true", help="忽略版本相同，强制全量更新")
    ap.add_argument(
        "--update-yoo", action="store_true", help="先 git pull 云端 YooAsset 脚本"
    )
    ap.add_argument(
        "--version",
        dest="override_version",
        default=None,
        help="跳过版本检查，强制指定版本",
    )
    args = ap.parse_args()

    if args.decrypt_only:
        encrypt_start, key = bytes.fromhex(ENCRYPT_START_HEX), bytes.fromhex(KEY256_HEX)
        custom_key = bytes.fromhex(args.key_hex) if args.key_hex else DEFAULT_CUSTOM_KEY
        total, decrypted, unchanged, suspicious = decrypt_tree(
            args.assets_dir, args.master_dir, encrypt_start, key, custom_key, args.ext
        )
        print(
            f"[done] 解密完成: 共 {total} 个, 解密 {decrypted} 个, "
            f"原样 {unchanged} 个, 可疑 {suspicious} 个 -> {args.master_dir}"
        )
        return 0

    ensure_yooasset(args.yoo_dir, update=args.update_yoo)

    work_dir = args.work_dir
    manifest_dir = work_dir / "manifests"
    manifest_dir.mkdir(parents=True, exist_ok=True)

    if args.override_version:
        version = args.override_version
        print(f"[version] 远端(指定): {version}")
    else:
        version = remote_version(args.base_url)
        print(f"[version] 远端: {version}")

    cur_version = local_version(
        work_dir,
        yoo_dir=args.yoo_dir,
    )
    print(f"[version] 本地: {cur_version or '(无)'}")
    manifest_path = manifest_dir / f"packageScript_{version}.bytes"
    if not manifest_path.exists() or args.force:
        manifest_data = http_get(
            f"{args.base_url}/{version}/Android/Script/packageScript_{version}.bytes"
        )
        manifest_path.write_bytes(manifest_data)
    else:
        manifest_data = manifest_path.read_bytes()
    manifest, bundles = parse_manifest(manifest_data)
    print(
        f"[manifest] {manifest.package_name} {manifest.package_version}, "
        f"{len(bundles)} bundles, 其中数据表包 {len(script_bundles(bundles))} 个"
    )

    need_update = args.force or cur_version != version
    script_list = script_bundles(bundles)
    bundle_versions = fetch_version_info(
        args.base_url, version, work_dir, force=args.force
    )
    missing_local = [
        b for b in script_list if find_existing_bundle(work_dir, b) is None
    ]

    if need_update:
        todo = script_list
        print(
            f"[update] 强制全量同步数据表包"
            if args.force and cur_version == version
            else f"[update] 版本变化 {cur_version} -> {version}，全量同步数据表包"
        )
    else:
        todo = missing_local
        print(
            f"[update] 版本相同，需要补下 {len(todo)} 个包"
            if todo
            else "[update] 版本相同且本地包完整，无需更新"
        )
        if not todo:
            (work_dir / "current_version.txt").write_text(version)
            return 0

    extracted: list[Path] = []
    for b in todo:
        local = find_existing_bundle(work_dir, b)
        if local is None:
            bver = bundle_versions.get(b.bundle_name, version)
            local = download_bundle(args.base_url, bver, b, work_dir)
        else:
            print(f"[use-local] {b.bundle_name} <- {local}")
        extracted.extend(extract_bundle(local, b.bundle_name, args.assets_dir))

    encrypt_start, key = bytes.fromhex(ENCRYPT_START_HEX), bytes.fromhex(KEY256_HEX)
    custom_key = bytes.fromhex(args.key_hex) if args.key_hex else DEFAULT_CUSTOM_KEY
    decrypted, unchanged = decrypt_paths(
        extracted, args.assets_dir, args.master_dir, encrypt_start, key, custom_key
    )

    (work_dir / "current_version.txt").write_text(version)
    print(
        f"[done] 更新完成: 解包 {len(extracted)} 个 Lua, "
        f"解密 {decrypted} 个, 原样 {unchanged} 个 -> {args.master_dir}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
