from __future__ import annotations

"""反向蓝动态 dump：frida spawn 游戏抓「启动流程」的真实 HTTP，动态还原接口映射。

游戏把接口路由（/api/uuid/<uuid>）和 reverse-version-key 都编译在 libil2cpp 里，
且 so 被壳化，纯 APK 静态分析拿不到「UUID -> 接口角色」的映射。本工具直接动态抓包：
spawn 游戏 → hook UnityWebRequest.set_url / SetRequestHeader / DownloadHandler / UploadHandlerRaw，
抓启动流程的 URL、reverse-version-key 头和响应体；再按响应内容语义自动判定四个角色：
    app_config  : 响应 msgpack 含 AnnouncementUrl + TermsOfServiceText
    session     : 响应 msgpack 含 SessionId
    startup     : 响应 msgpack 含 ConsecutiveLoginDay1AndDay2
    masterdata  : 响应长度 > 10MB（约 80MB 的全量数据表）
不写死任何 UUID / 下标 / 类名；每个客户端版本跑一次，结果写入
Cache/ReverseBlueEndpoints.json 供 ReverseBlue.py 使用。

用法：
    python3 ReverseBlueFrida.py                     # 抓取并写 Cache/ReverseBlueEndpoints.json
    python3 ReverseBlueFrida.py --timeout 240
    python3 ReverseBlueFrida.py -o /tmp/endpoints.json

前置：设备已连接 + frida-server(ajeossida) 在 127.0.0.1:27042 可达；缺省自动 adb forward。
"""

import argparse
import datetime as dt
import json
import subprocess
import threading
from pathlib import Path
from typing import Any

import frida
import msgpack
from rich.console import Console
from rich.table import Table

SCRIPT_DIR = Path(__file__).resolve().parent
CACHE_DIR = SCRIPT_DIR / "Cache"
ENDPOINTS_FILE = CACHE_DIR / "ReverseBlueEndpoints.json"
AGENT_FILE = SCRIPT_DIR / "ReverseBlueFridaAgent.js"

PACKAGE = "jp.co.happyelements.rxr"
FRIDA_HOST = "127.0.0.1:27042"
ADB_LOCAL_PORT = 27042
ADB_DEVICE_PORT = 45678
ROLE_ORDER = ("startup", "session", "app_config", "masterdata")

console = Console()


class CaptureError(RuntimeError):
    pass


def _adb(*arguments: str) -> subprocess.CompletedProcess:
    return subprocess.run(["adb", *arguments], capture_output=True, text=True, timeout=60)


def ensure_frida_forward(serial: str | None = None) -> None:
    serial_args = ["-s", serial] if serial else []
    listing = _adb(*serial_args, "forward", "--list").stdout
    if f"tcp:{ADB_LOCAL_PORT}" in listing:
        return
    result = _adb(*serial_args, "forward", f"tcp:{ADB_LOCAL_PORT}", f"tcp:{ADB_DEVICE_PORT}")
    if result.returncode != 0:
        raise CaptureError(f"adb forward 失败: {result.stderr.strip()}")


def force_stop(serial: str | None = None) -> None:
    serial_args = ["-s", serial] if serial else []
    _adb(*serial_args, "shell", "su", "-c", f"am force-stop {PACKAGE}")


def _msgpack_keys(data: bytes) -> set[str]:
    try:
        value = msgpack.unpackb(data, raw=False, strict_map_key=False)
    except Exception:  # noqa: BLE001
        return set()
    if isinstance(value, dict):
        return {str(key) for key in value}
    return set()


def _uuid_from_url(url: str) -> str:
    prefix = "/api/uuid/"
    marker = url.find(prefix)
    if marker < 0:
        return url
    rest = url[marker + len(prefix):]
    return rest.split("?")[0].strip("/")


def classify(responses: list[dict[str, Any]]) -> dict[str, dict[str, Any]]:
    """按响应内容语义判定接口角色（不看 URL/类名）。"""
    roles: dict[str, dict[str, Any]] = {}
    for item in responses:
        url = str(item.get("url") or "")
        if not url:
            continue
        data = item.get("data") or b""
        length = int(item.get("len") or len(data))
        keys = _msgpack_keys(data)
        role = None
        if "AnnouncementUrl" in keys and "TermsOfServiceText" in keys:
            role = "app_config"
        elif "SessionId" in keys:
            role = "session"
        elif "ConsecutiveLoginDay1AndDay2" in keys:
            role = "startup"
        elif length > 10 * 1024 * 1024:
            role = "masterdata"
        if role and role not in roles:
            roles[role] = {"url": url, "keys": sorted(keys)[:16], "len": length}
    return roles


def capture(
    *,
    serial: str | None = None,
    timeout: int = 240,
    output: Path = ENDPOINTS_FILE,
    quiet: bool = False,
) -> dict[str, Any]:
    if not AGENT_FILE.is_file():
        raise CaptureError(f"缺少 frida agent: {AGENT_FILE}（frida-compile 编译 ReverseBlueFridaAgent.ts）")
    ensure_frida_forward(serial)
    force_stop(serial)

    manager = frida.get_device_manager()
    try:
        device = manager.add_remote_device(FRIDA_HOST)
    except Exception as exc:  # noqa: BLE001
        raise CaptureError(f"连接 frida {FRIDA_HOST} 失败: {exc}") from exc

    done = threading.Event()
    state: dict[str, Any] = {
        "appVersion": None,
        "versionKey": None,
        "catalogVersion": None,
        "responses": [],
        "bootUrls": [],
        "errors": [],
    }
    wanted = set(ROLE_ORDER)

    def current_roles() -> dict[str, dict[str, Any]]:
        return classify(state["responses"])

    def check_done() -> None:
        if done.is_set():
            return
        roles = current_roles()
        if wanted.issubset(roles):
            done.set()

    def on_message(message: dict[str, Any], data: bytes | None) -> None:
        if message.get("type") != "send":
            if message.get("type") == "error":
                state["errors"].append(str(message.get("description") or message))
                done.set()
            return
        payload = message.get("payload") or {}
        kind = payload.get("kind")
        if kind == "ready":
            info = payload.get("data") or {}
            state["appVersion"] = state["appVersion"] or info.get("appVersion")
            if info.get("versionKey"):
                state["versionKey"] = info["versionKey"]
        elif kind == "version-key":
            value = (payload.get("data") or {}).get("value")
            if value:
                state["versionKey"] = value
        elif kind == "url":
            url = (payload.get("data") or {}).get("url")
            if url and url not in state["bootUrls"]:
                state["bootUrls"].append(url)
        elif kind == "body":
            url = payload.get("url") or ""
            if data and url:
                state["responses"].append({
                    "url": url,
                    "dir": payload.get("dir"),
                    "len": payload.get("len") or len(data),
                    "data": bytes(data)[: 2 * 1024 * 1024],
                })
                check_done()
            elif data and not url and payload.get("dir") == "resp":
                state["responses"].append({"url": "", "dir": "resp", "len": len(data), "data": bytes(data)[: 4096]})
        elif kind == "body-meta":
            url = payload.get("url") or ""
            head = data or b""
            state["responses"].append({
                "url": url,
                "dir": payload.get("dir"),
                "len": payload.get("len") or len(head),
                "data": bytes(head)[:4096],
            })
            check_done()

    if not quiet:
        console.print(f"[cyan]spawn[/cyan] {PACKAGE} ...")
    pid = device.spawn([PACKAGE])
    session = None
    try:
        session = device.attach(pid)
        script = session.create_script(AGENT_FILE.read_text(encoding="utf-8"))
        script.on("message", on_message)
        script.load()
        device.resume(pid)
        if not quiet:
            console.print(f"[cyan]等待启动流程[/cyan] (pid={pid}, timeout={timeout}s) ...")
        if not done.wait(timeout):
            raise CaptureError("采集超时：启动流程未在限定时间内出现全部 4 个接口")
        if state["errors"]:
            raise CaptureError(f"agent 报错: {state['errors'][0]}")
    finally:
        try:
            if session is not None:
                session.detach()
        except Exception:  # noqa: BLE001
            pass
        try:
            device.kill(pid)
        except Exception:  # noqa: BLE001
            pass
        force_stop(serial)

    roles = current_roles()
    missing = [role for role in ROLE_ORDER if role not in roles]
    if missing:
        urls = sorted({str(item.get("url")) for item in state["responses"] if item.get("url")})
        raise CaptureError(
            f"无法从启动流量判定角色 {missing}；已捕获 URL: {urls}"
        )
    session_data = next(
        (
            item
            for item in state["responses"]
            if item.get("url") == roles["session"]["url"] and item.get("data")
        ),
        {},
    )
    try:
        session_map = msgpack.unpackb(session_data.get("data") or b"", raw=False, strict_map_key=False)
        catalog_version = session_map.get("CatalogVersion") if isinstance(session_map, dict) else None
    except Exception:  # noqa: BLE001
        catalog_version = None
    data = {
        "gamePackage": PACKAGE,
        "appVersion": state["appVersion"],
        "versionKey": state["versionKey"],
        "catalogVersion": catalog_version,
        "capturedAt": dt.datetime.now().astimezone().isoformat(timespec="seconds"),
        "uuids": {role: _uuid_from_url(roles[role]["url"]) for role in ROLE_ORDER},
        "routes": {role: roles[role]["url"] for role in ROLE_ORDER},
        "bootUrls": state["bootUrls"],
    }
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
    if not quiet:
        table = Table(title="动态抓包得到的接口映射")
        table.add_column("角色", style="cyan")
        table.add_column("响应特征")
        table.add_column("/api/uuid/...")
        for role in ROLE_ORDER:
            entry = roles[role]
            table.add_row(role, ", ".join(entry["keys"][:3]), _uuid_from_url(entry["url"]))
        console.print(table)
        console.print(
            f"[green]动态采集完成[/green] appVersion={data['appVersion']}  "
            f"versionKey={'已抓到' if data['versionKey'] else '未抓到'}  "
            f"catalogVersion={catalog_version} → {output}"
        )
    return data


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="反向蓝动态抓包还原接口映射（不依赖内置 UUID/版本常量）")
    parser.add_argument("--serial", default="", help="adb 设备序列号（默认唯一连接的设备）")
    parser.add_argument("--timeout", type=int, default=240, help="等待启动流程的秒数，默认 240")
    parser.add_argument("-o", "--output", default=str(ENDPOINTS_FILE), help=f"输出 JSON，默认 {ENDPOINTS_FILE}")
    return parser


def main() -> int:
    args = build_parser().parse_args()
    try:
        capture(serial=args.serial or None, timeout=args.timeout, output=Path(args.output))
    except CaptureError as exc:
        console.print(f"[red]采集失败[/red]: {exc}")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
