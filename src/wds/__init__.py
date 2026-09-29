"""WDS (World Dai Star: Yumeno Stella) game API toolkit.

Modules:
    codec       - MessagePack wire codec (base64-as-fixints, ext-98/99 LZ4 frames)
    api         - HTTP client and endpoint wrappers
    token_store - dynamic token persistence (login token + Bearer token)
    login       - 引继 (take-over) flow, authenticate and login orchestration
    metadata    - il2cpp.cs type / MemoryTable / [Key] field index
    master_data - master data manifest, download and MasterMemory .db decode
    har_decode  - decode every /api/* response body from a HAR capture
    cli         - command line entry points
"""

__version__ = "0.1.0"
