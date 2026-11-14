from __future__ import annotations

"""反向蓝 / ReverseBlue Re-birthEnd (jp.co.happyelements.rxr) 客户端 API。

接口复刻自 1.31.3 客户端（HAR 抓包 + metadata 字符串字面量 + il2cpp 反编译）：
- 启动版本检查: POST /api/uuid/7074ef60-...  空 body
- 会话创建:     POST /api/uuid/9f463175-...  msgpack {UniqueKey, Idfa, AndroidId}
- 应用配置:     GET  /api/uuid/a0457be5-...
- 数据表:       GET  /api/uuid/dc84ef7e-...
全部请求/响应为 application/x-msgpack，鉴权只依赖固定请求头 + 服务端下发的 X-Session。
"""

import os
import uuid
from typing import Any

import msgpack
import requests

API_BASE = "https://app.rxr.grimoire.codes"
CDN_BASE = "https://cdn.rxr.grimoire.codes"
PLATFORM = "Android"
APP_VERSION = "1.31.3"
VERSION_KEY = "8AY3HisTx6mNhpgkPpPjXwNTnSQSYMYJsYUFZuUDKxm9VDJyxG"
UNITY_VERSION = "2022.3.61f1"
DEVICE_MODEL = "OnePlus PJE110"
DEVICE_AGENT = "OnePlus PJE110:::Android OS 15 / API-35 (TP1A.220905.001/U.1eb775b_ed04f_e2ccf)"
USER_AGENT = "UnityPlayer/2022.3.61f1 (UnityWebRequest/1.0, libcurl/8.10.1-DEV)"
TIMEOUT = 120
CHUNK = 1 << 20

# 1.31.3 客户端内置的接口 UUID（每个版本由后端重新生成、随 APK 编译进
# global-metadata.dat 的字符串字面量；服务端不会下发，见 ReverseBlueMetadata.py）。
ENDPOINT_UUIDS = {
    "startup": "7074ef60-ad15-452b-afe0-6564da6b3a48",
    "session": "9f463175-74d4-41cc-90f9-5856af16aa13",
    "app_config": "a0457be5-de77-479d-a093-8bf48a3852fe",
    "masterdata": "dc84ef7e-9b1b-43d1-8f4a-635da0e3ee73",
}

# 439 条路由字面量是连续排布的生成块；该下标在 1.31.3 版本内的位置。
# 版本更新、UUID 变化时可用这些下标从新版本的 metadata 路由块里重新定位。
ENDPOINT_INDICES = {
    "startup": 190,
    "session": 264,
    "app_config": 268,
    "masterdata": 374,
}


def api_path(endpoint: str) -> str:
    """endpoint 可以是完整路径或裸 UUID。"""
    if endpoint.startswith("/"):
        return endpoint
    return f"/api/uuid/{endpoint}"


class ApiError(RuntimeError):
    """服务端返回非 0 状态或 HTTP 错误。"""


def random_android_id() -> str:
    return os.urandom(16).hex()


def random_tracking_id() -> str:
    return os.urandom(16).hex()


def build_headers(
    *,
    session_id: str = "",
    version: str = APP_VERSION,
    version_key: str = VERSION_KEY,
    content_type: str = "application/x-msgpack",
) -> dict[str, str]:
    """构造客户端请求头（对应 Reverse.Api 的 ApiClient 默认头）。"""
    headers = {
        "User-Agent": USER_AGENT,
        "Accept": "application/x-msgpack",
        "reverse-user-agent": DEVICE_AGENT,
        "reverse-device-model": DEVICE_MODEL,
        "reverse-version": version,
        "reverse-version-key": version_key,
        "platform": PLATFORM,
        "reverse-Tracking-Id": random_tracking_id(),
        "X-Request-Token": str(uuid.uuid4()),
        "X-Unity-Version": UNITY_VERSION,
    }
    if content_type:
        headers["Content-Type"] = content_type
    if session_id:
        headers["X-Session"] = session_id
    return headers


def _unpack(blob: bytes) -> Any:
    return msgpack.unpackb(blob, raw=False, strict_map_key=False)


def _ensure_ok(name: str, payload: Any) -> Any:
    if isinstance(payload, dict) and "AppStatusCode" in payload:
        code = payload.get("AppStatusCode") or 0
        if code != 0:
            raise ApiError(f"{name} 返回 AppStatusCode={code} AppMessage={payload.get('AppMessage')!r}")
    return payload


def create_session(
    *,
    endpoint: str = ENDPOINT_UUIDS["session"],
    version: str = APP_VERSION,
    version_key: str = VERSION_KEY,
    timeout: int = TIMEOUT,
) -> dict[str, Any]:
    """注册/恢复游客会话，响应含 SessionId / CatalogVersion / MasterDataModifiedTime。"""
    body = msgpack.packb(
        {
            "UniqueKey": str(uuid.uuid4()),
            "Idfa": None,
            "AndroidId": random_android_id(),
        },
        use_bin_type=True,
    )
    headers = build_headers(version=version, version_key=version_key)
    resp = requests.post(
        f"{API_BASE}{api_path(endpoint)}", headers=headers, data=body, timeout=timeout
    )
    resp.raise_for_status()
    return _ensure_ok("session", _unpack(resp.content))


def get_startup_info(
    session_id: str = "",
    *,
    endpoint: str = ENDPOINT_UUIDS["startup"],
    version: str = APP_VERSION,
    version_key: str = VERSION_KEY,
    timeout: int = TIMEOUT,
) -> dict[str, Any]:
    """启动版本检查：CatalogVersion / MasterDataModifiedTime / InfoBars 等。"""
    headers = build_headers(
        session_id=session_id,
        version=version,
        version_key=version_key,
        content_type="application/x-www-form-urlencoded",
    )
    resp = requests.post(
        f"{API_BASE}{api_path(endpoint)}", headers=headers, data=b"", timeout=timeout
    )
    resp.raise_for_status()
    return _ensure_ok("startup", _unpack(resp.content))


def get_app_config(
    session_id: str = "",
    *,
    endpoint: str = ENDPOINT_UUIDS["app_config"],
    version: str = APP_VERSION,
    version_key: str = VERSION_KEY,
    timeout: int = TIMEOUT,
) -> dict[str, Any]:
    """应用配置/公告/隐私政策等文本。"""
    headers = build_headers(session_id=session_id, version=version, version_key=version_key)
    resp = requests.get(
        f"{API_BASE}{api_path(endpoint)}", headers=headers, timeout=timeout
    )
    resp.raise_for_status()
    return _ensure_ok("app_config", _unpack(resp.content))


def get_masterdata(
    session_id: str = "",
    *,
    endpoint: str = ENDPOINT_UUIDS["masterdata"],
    version: str = APP_VERSION,
    version_key: str = VERSION_KEY,
    timeout: int = TIMEOUT,
) -> bytes:
    """获取全量数据表 msgpack（约 80MB）。"""
    headers = build_headers(session_id=session_id, version=version, version_key=version_key)
    resp = requests.get(
        f"{API_BASE}{api_path(endpoint)}", headers=headers, timeout=timeout
    )
    resp.raise_for_status()
    payload = _ensure_ok("masterdata", _unpack(resp.content))
    return resp.content if isinstance(payload, dict) else resp.content
