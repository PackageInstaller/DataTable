from __future__ import annotations

import io
import struct
import sys
import warnings
from pathlib import Path


def extract_config_bin(ys_path: Path) -> bytes:
    import UnityPy
    import UnityPy.config as ucfg
    from UnityPy.config import UnityVersionFallbackWarning

    warnings.filterwarnings("ignore", category=UnityVersionFallbackWarning)

    ucfg.FALLBACK_UNITY_VERSION = "2022.3.62f1c1"

    raw = ys_path.read_bytes()
    off = raw.find(b"UnityFS")
    if off <= 0:
        raise ValueError(f"{ys_path} 不是 UnityFS AssetBundle")

    env = UnityPy.load(io.BytesIO(raw[off:]))
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        ta = obj.read()
        if getattr(ta, "m_Name", None) != "Config":
            continue
        data = obj.get_raw_data()
        script_len = struct.unpack_from("<I", data, 0x0C)[0]
        script = data[0x10 : 0x10 + script_len]
        return bytes(script)
    raise ValueError("config.ys 内未找到 TextAsset 'Config'")


def main() -> int:
    if len(sys.argv) < 2:
        print(__doc__)
        return 2
    ys = Path(sys.argv[1])
    out = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("Config.bin")
    data = extract_config_bin(ys)
    out.write_bytes(data)
    print(f"[*] {ys} -> {out} ({len(data)} bytes)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
