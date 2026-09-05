"""
YooAsset 常量定义

包含文件签名、支持版本号等全局常量。
"""

# ── 清单文件 (PackageManifest) ────────────────────────────

# 文件头魔数 (ASCII: "YOO")
MANIFEST_FILE_SIGN: int = 0x594F4F

# v2.x 系列：版本号为 UTF-8 字符串
SUPPORTED_VERSIONS: list[str] = [
    "1.5.2",
    "2.0.0",
    "2.3.1",
    "2025.8.28",
    "2025.9.30",
]

# v3.0+：版本号为 int32 整数
MANIFEST_V3_FILE_VERSION: int = 1

# ── 内置目录 (BuildinCatalog) ─────────────────────────────

# 文件头魔数
BUILDIN_CATALOG_FILE_SIGN: int = 0x133C5EE

# v2.x 系列：版本号为 UTF-8 字符串
BUILDIN_CATALOG_VERSION: str = "1.0.0"

# v3.0+：版本号为 int32 整数
BUILDIN_CATALOG_V3_FILE_VERSION: int = 1
