from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path
from yooasset import deserialize_from_bytes, deserialize_from_file
from yooasset.models import PackageAsset, PackageBundle, PackageManifest



@dataclass
class BundleIndex:
    manifest: PackageManifest
    bundle_by_hash: dict[str, PackageBundle] = field(default_factory=dict)
    bundle_by_name: dict[str, PackageBundle] = field(default_factory=dict)
    assets_by_bundle_id: dict[int, list[PackageAsset]] = field(default_factory=dict)
    assets_by_bundle_hash: dict[str, list[PackageAsset]] = field(default_factory=dict)

    @classmethod
    def build(cls, manifest: PackageManifest) -> "BundleIndex":
        idx = cls(manifest=manifest)
        for i, b in enumerate(manifest.bundle_list):
            idx.bundle_by_hash[b.file_hash] = b
            idx.bundle_by_name[b.bundle_name] = b
            idx.assets_by_bundle_id.setdefault(i, [])
        for a in manifest.asset_list:
            idx.assets_by_bundle_id.setdefault(a.bundle_id, []).append(a)
        for bid, assets in idx.assets_by_bundle_id.items():
            if 0 <= bid < len(manifest.bundle_list):
                h = manifest.bundle_list[bid].file_hash
                idx.assets_by_bundle_hash.setdefault(h, []).extend(assets)
        return idx

    def bundle_path(self, bundles_dir: Path, bundle: PackageBundle, package_name: str = "") -> Path:
        assets = self.assets_by_bundle_hash.get(bundle.file_hash, [])
        rel = logical_relpath(bundle, assets, package_name or self.manifest.package_name)
        p = bundles_dir / rel
        if p.is_file():
            return p
        h = bundle.file_hash
        legacy = bundles_dir / h[:2] / h / "__data"
        if legacy.is_file():
            return legacy
        return p

    def asset_paths(self, bundle: PackageBundle) -> list[str]:
        return [a.asset_path for a in self.assets_by_bundle_hash.get(bundle.file_hash, [])]


def load_manifest(path: Path) -> PackageManifest:
    return deserialize_from_file(str(path))


def load_manifest_bytes(data: bytes) -> PackageManifest:
    return deserialize_from_bytes(data)


def manifest_summary(manifest: PackageManifest) -> dict:
    return {
        "file_version": str(manifest.file_version),
        "package_name": manifest.package_name,
        "package_version": manifest.package_version,
        "package_note": manifest.package_note,
        "build_pipeline": manifest.build_pipeline,
        "assets": len(manifest.asset_list),
        "bundles": len(manifest.bundle_list),
    }


def logical_relpath(
    bundle: PackageBundle,
    assets: list[PackageAsset] | None = None,
    package_name: str = "",
) -> str:
    if package_name == "RawFile" or bundle.bundle_name.startswith("rawfile_"):
        if assets and assets[0].asset_path:
            return assets[0].asset_path.replace("\\", "/")
    from yooasset.extractor import convert_bundle_name_to_path

    rel = convert_bundle_name_to_path(bundle.bundle_name).replace("\\", "/")
    if not (rel.endswith(".bundle") or rel.endswith(".rawfile") or rel.endswith(".mp4")):
        rel += ".bundle"
    return rel


def build_catalog_dict(manifest: PackageManifest) -> dict:
    idx = BundleIndex.build(manifest)
    res = {
        "package_name": manifest.package_name,
        "package_version": manifest.package_version,
        "total_bundles": len(manifest.bundle_list),
        "total_assets": len(manifest.asset_list),
        "bundles": [],
    }
    for b in manifest.bundle_list:
        assets = idx.assets_by_bundle_hash.get(b.file_hash, [])
        res["bundles"].append({
            "bundle_name": b.bundle_name,
            "file_hash": b.file_hash,
            "file_size": b.file_size,
            "download_tag": b.download_tag,
            "logical_path": logical_relpath(b, assets, manifest.package_name),
            "asset_paths": [a.asset_path for a in assets],
            "addresses": [a.address for a in assets if a.address],
        })
    return res


def migrate_hash_layout(
    bundle_dir: Path,
    manifest: PackageManifest,
    log_fn=None,
) -> int:
    if not bundle_dir.is_dir():
        return 0
    import os

    idx = BundleIndex.build(manifest)
    hash_map = {
        b.file_hash: logical_relpath(b, idx.assets_by_bundle_hash.get(b.file_hash, []), manifest.package_name)
        for b in manifest.bundle_list
    }
    moved = 0
    for legacy in list(bundle_dir.rglob("__data")):
        file_hash = legacy.parent.name
        rel = hash_map.get(file_hash)
        if not rel:
            continue
        dest = bundle_dir / rel
        dest.parent.mkdir(parents=True, exist_ok=True)
        if dest.is_file() and dest.stat().st_size == legacy.stat().st_size:
            legacy.unlink()
        else:
            if dest.exists():
                dest.unlink()
            os.rename(legacy, dest)
        info = legacy.with_name("__info")
        if info.exists():
            info.unlink()
        try:
            legacy.parent.rmdir()
            legacy.parent.parent.rmdir()
        except OSError:
            pass
        moved += 1
    return moved


def restore_package_links(
    manifest: PackageManifest,
    bundles_dir: Path,
    out_dir: Path,
    symlink: bool = True,
) -> int:
    import os
    import shutil

    idx = BundleIndex.build(manifest)
    count = 0
    for b in manifest.bundle_list:
        src = idx.bundle_path(bundles_dir, b, manifest.package_name)
        if not src.is_file():
            continue
        assets = idx.assets_by_bundle_hash.get(b.file_hash, [])
        rel = logical_relpath(b, assets, manifest.package_name)
        dest = out_dir / rel
        if dest.resolve() == src.resolve():
            continue

        parent = dest.parent
        parts = list(parent.parts)
        for i in range(1, len(parts) + 1):
            cur = Path(*parts[:i])
            if cur.exists() and cur.is_file():
                bumped = cur.with_name(cur.name + ".bundle")
                if not bumped.exists():
                    cur.rename(bumped)
                else:
                    cur.unlink()
        parent.mkdir(parents=True, exist_ok=True)

        if dest.is_symlink() or dest.exists():
            dest.unlink()
        if symlink:
            os.symlink(src.resolve(), dest)
        else:
            shutil.copy2(src, dest)
        count += 1
    return count


