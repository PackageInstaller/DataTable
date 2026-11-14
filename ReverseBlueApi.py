from __future__ import annotations

"""反向蓝 / ReverseBlue Re-birthEnd (jp.co.happyelements.rxr) 客户端 API。

接口复刻自客户端实际抓包（HAR + frida 动态 dump）。所有请求/响应为
application/x-msgpack，鉴权只依赖固定请求头 + 服务端下发的 X-Session。

注意：接口路由（/api/uuid/<uuid>）与 reverse-version-key 是每个客户端版本
编译进 libil2cpp 的常量，服务端不下发。本模块不内置它们；调用方必须传入从
Cache/ReverseBlueEndpoints.json（ReverseBlueFrida.py 动态抓包生成）或参数得到的值。
"""

import os
import uuid
from typing import Any

import msgpack
import requests

API_BASE = "https://app.rxr.grimoire.codes"
CDN_BASE = "https://cdn.rxr.grimoire.codes"
PLATFORM = "Android"
UNITY_VERSION = "2022.3.61f1"
DEVICE_MODEL = "OnePlus PJE110"
DEVICE_AGENT = "OnePlus PJE110:::Android OS 15 / API-35 (TP1A.220905.001/U.1eb775b_ed04f_e2ccf)"
USER_AGENT = "UnityPlayer/2022.3.61f1 (UnityWebRequest/1.0, libcurl/8.10.1-DEV)"
TIMEOUT = 120
CHUNK = 1 << 20


def api_path(endpoint: str) -> str:
    """endpoint 可以是完整路径、完整 URL 或裸 UUID。"""
    if endpoint.startswith("http"):
        return endpoint
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
    session_id: str,
    version: str,
    version_key: str,
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
    endpoint: str,
    version: str,
    version_key: str,
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
    headers = build_headers(session_id="", version=version, version_key=version_key)
    resp = requests.post(
        f"{API_BASE}{api_path(endpoint)}", headers=headers, data=body, timeout=timeout
    )
    resp.raise_for_status()
    return _ensure_ok("session", _unpack(resp.content))


def get_startup_info(
    session_id: str,
    *,
    endpoint: str,
    version: str,
    version_key: str,
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
    session_id: str,
    *,
    endpoint: str,
    version: str,
    version_key: str,
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
    session_id: str,
    *,
    endpoint: str,
    version: str,
    version_key: str,
    timeout: int = TIMEOUT,
) -> bytes:
    """获取全量数据表 msgpack（约 80MB）。"""
    headers = build_headers(session_id=session_id, version=version, version_key=version_key)
    resp = requests.get(
        f"{API_BASE}{api_path(endpoint)}", headers=headers, timeout=timeout
    )
    resp.raise_for_status()
    _ensure_ok("masterdata", _unpack(resp.content))
    return resp.content
