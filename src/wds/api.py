"""HTTP client and endpoint wrappers for the WDS Sirius API.

Endpoints (all responses are MessagePack streams; see codec.py):

    POST /api/Environment?applicationVersion=<v>&gameVersion=2   - no auth
    POST /api/Account/GetTakeOverAccount                          - 引继 import
    POST /api/Account/Authenticate                                - login token -> Bearer
    POST /api/Login                                               - Bearer -> user data
    GET  /api/data/master                                         - master data manifest
    GET  /api/data/user                                           - user data objects
"""

from __future__ import annotations

import base64
import json
import urllib.error
import urllib.request
from dataclasses import dataclass
from typing import Any

from . import codec


API_BASE = "https://lb-api.wds-stellarium.com"
GAME_VERSION = 2  # GameVersions.GooglePlay
APP_ID = "com.kms.worlddaistar"


class ApiError(RuntimeError):
    """Raised when the server returns a non-2xx status."""

    def __init__(self, status: int, body: bytes):
        self.status = status
        self.body = body
        super().__init__(f"HTTP {status}: {body[:300]!r}")


@dataclass(frozen=True)
class EnvironmentResult:
    application_version: str
    asset_version: str
    api_endpoint: str
    maintenance_api_endpoint: str | None
    news_api_endpoint: str | None
    is_maintenance: bool
    master_data_url: str
    static_content_url: str
    asset_url: str
    is_app_review: bool
    photo_content_url: str
    multi_realtime_server_url: str
    external_payment_url: str

    @classmethod
    def from_payload(cls, values: list[Any]) -> "EnvironmentResult":
        fields = [
            "application_version", "asset_version", "api_endpoint",
            "maintenance_api_endpoint", "news_api_endpoint", "is_maintenance",
            "master_data_url", "static_content_url", "asset_url",
            "is_app_review", "photo_content_url", "multi_realtime_server_url",
            "external_payment_url",
        ]
        return cls(**dict(zip(fields, values)))


@dataclass(frozen=True)
class MasterDataManifest:
    uri: str
    sas_token: str
    version: str
    publish_timestamp: int

    @classmethod
    def from_payload(cls, values: list[Any]) -> "MasterDataManifest":
        return cls(uri=values[0], sas_token=values[1],
                   version=values[2], publish_timestamp=values[3])


@dataclass(frozen=True)
class TakeOverAccountResult:
    is_success: bool
    user_id: str | None
    name: str | None
    rank: int | None
    login_token: str | None

    @classmethod
    def from_payload(cls, values: list[Any]) -> "TakeOverAccountResult":
        return cls(
            is_success=bool(values[0]),
            user_id=values[1],
            name=values[2],
            rank=values[3],
            login_token=values[4],
        )


@dataclass(frozen=True)
class AuthenticateResult:
    token: str
    ban_level: int
    warned_until: Any | None

    @classmethod
    def from_payload(cls, values: list[Any]) -> "AuthenticateResult":
        return cls(token=values[0], ban_level=values[1], warned_until=values[2])


class ApiClient:
    """Thin HTTP wrapper matching the game's BestHTTP request conventions."""

    def __init__(
        self,
        api_base: str = API_BASE,
        platform: str = "google-play",
        user_agent: str = "BestHTTP/2 v2.8.5",
        timeout: int = 60,
    ):
        self.api_base = api_base.rstrip("/")
        self.platform = platform
        self.user_agent = user_agent
        self.timeout = timeout

    def _headers(self, token: str | None = None) -> dict[str, str]:
        headers = {
            "accept": "application/vnd.msgpack",
            "content-type": "application/vnd.msgpack",
            "x-platform": self.platform,
            "user-agent": self.user_agent,
            "x-fm": "0",
            "x-masterdata-version": self._masterdata_version(),
        }
        if token:
            headers["authorization"] = (
                token if token.startswith("Bearer ") else f"Bearer {token}"
            )
        return headers

    def _masterdata_version(self) -> str:
        import json as _json
        from pathlib import Path as _Path

        try:
            vf = _Path("masterdata/version.json")
            if vf.exists():
                return _json.loads(vf.read_text(encoding="utf-8")).get("version", "")
        except Exception:
            pass
        return ""

    def _request(
        self,
        method: str,
        path: str,
        body: bytes | None = None,
        token: str | None = None,
    ) -> list[Any]:
        url = self.api_base + path
        req = urllib.request.Request(
            url, data=body, method=method, headers=self._headers(token)
        )
        try:
            with urllib.request.urlopen(req, timeout=self.timeout) as resp:
                return codec.decode_response(resp.read())
        except urllib.error.HTTPError as ex:
            raise ApiError(ex.code, ex.read()) from ex

    def post(self, path: str, payload: Any, compressed: bool = False) -> list[Any]:
        return self._request("POST", path, codec.pack_request(payload, compressed))

    def get(self, path: str, token: str | None = None) -> list[Any]:
        return self._request("GET", path, token=token)

    # ------------------------------------------------------------ endpoints

    def fetch_environment(self, app_version: str | None = None) -> EnvironmentResult:
        if app_version is None:
            app_version = current_app_version()
        path = (
            f"/api/Environment?applicationVersion={app_version}"
            f"&gameVersion={GAME_VERSION}"
        )
        payloads = self._request("POST", path, b"")
        for obj in payloads:
            if isinstance(obj, list) and len(obj) == 13:
                return EnvironmentResult.from_payload(obj)
        raise RuntimeError("unexpected environment response")

    def get_take_over_account(
        self, linkage_code: str, password: str
    ) -> TakeOverAccountResult:
        payloads = self.post("/api/Account/GetTakeOverAccount",
                             [linkage_code, password])
        for obj in payloads:
            if isinstance(obj, list) and len(obj) == 5:
                return TakeOverAccountResult.from_payload(obj)
        raise RuntimeError("unexpected take over account response")

    def authenticate(
        self,
        login_token: str,
        *,
        apk_hash: str = "",
        apk_application_signature: str = "",
        app_version: str | None = None,
        compressed: bool = False,
    ) -> AuthenticateResult:
        payload = [
            login_token,
            GAME_VERSION,
            apk_hash,
            apk_application_signature,
            app_version or current_app_version(),
        ]
        payloads = self.post("/api/Account/Authenticate", payload,
                             compressed=compressed)
        for obj in payloads:
            if isinstance(obj, list) and len(obj) >= 3:
                return AuthenticateResult.from_payload(obj)
        raise RuntimeError("unexpected authenticate response")

    def login(self, token: str) -> list[Any]:
        return self._request(
            "POST", "/api/Login", codec.pack_request([None]), token=token
        )

    def fetch_master_manifest(self, token: str) -> MasterDataManifest:
        payloads = self.get("/api/data/master", token)
        for obj in payloads:
            if isinstance(obj, list) and len(obj) == 4:
                return MasterDataManifest.from_payload(obj)
        raise RuntimeError("unexpected master data manifest response")


def current_app_version() -> str:
    """Best-effort application version; falls back to the last known value."""
    try:
        from google_play_scraper import app

        return app(app_id=APP_ID, lang="en", country="jp")["version"]
    except Exception:
        return "2.31.2"


def extract_token_from_har(har_path: str) -> str | None:
    """Pull the first Bearer authorization header out of a HAR capture."""
    with open(har_path, encoding="utf-8") as f:
        har = json.load(f)
    for entry in har["log"]["entries"]:
        for h in entry["request"]["headers"]:
            if h["name"].lower() == "authorization" and h["value"].startswith("Bearer"):
                return h["value"]
    return None


def b64(msg: bytes) -> bytes:
    """HAR display helper: bodies are shown as base64 text in captures."""
    return base64.b64encode(msg)
