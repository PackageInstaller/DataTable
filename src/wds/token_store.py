"""Dynamic token storage for the WDS login session.

Mirrors the game's persistence model:

  * the login (transition) token is the long-lived credential the game keeps
    under PlayerPrefs key "wEWm7nMyrRZe" (DefaultPreferencesKeys.LoginTokenKey);
  * the Bearer API token is short-lived and re-issued by Authenticate; we keep
    it together with its JWT exp so it can be refreshed dynamically.

The store is a small JSON file written atomically; paths never contain the
token in the file name so the actual value only lives in the file content.
"""

from __future__ import annotations

import base64
import json
import os
import tempfile
import time
from dataclasses import asdict, dataclass, field
from pathlib import Path


GAME_PREFS_KEY = "wEWm7nMyrRZe"  # DefaultPreferencesKeys.LoginTokenKey


@dataclass
class Credentials:
    login_token: str | None = None
    api_token: str | None = None
    api_token_exp: int | None = None
    user_id: str | None = None
    user_name: str | None = None
    rank: int | None = None
    updated_at: str = field(default="")

    def has_login_token(self) -> bool:
        return bool(self.login_token)

    def has_valid_api_token(self, margin: int = 300) -> bool:
        if not self.api_token or not self.api_token_exp:
            return False
        return self.api_token_exp - margin > int(time.time())


def parse_jwt_exp(jwt: str) -> int | None:
    """Extract the exp claim (epoch seconds) from a JWT, if present."""
    try:
        payload_b64 = jwt.split(".")[1]
        payload_b64 += "=" * (-len(payload_b64) % 4)
        payload = json.loads(base64.urlsafe_b64decode(payload_b64))
        return int(payload["exp"])
    except Exception:
        return None


class TokenStore:
    """JSON-backed credentials store with atomic writes."""

    def __init__(self, path: str | os.PathLike[str] = "credentials.json"):
        self.path = Path(path)

    def load(self) -> Credentials:
        if not self.path.exists():
            return Credentials()
        try:
            data = json.loads(self.path.read_text(encoding="utf-8"))
            return Credentials(**{k: data.get(k) for k in asdict(Credentials())})
        except Exception:
            return Credentials()

    def save(self, creds: Credentials) -> None:
        creds.updated_at = time.strftime("%Y-%m-%dT%H:%M:%S%z")
        payload = json.dumps(asdict(creds), ensure_ascii=False, indent=2)
        fd, tmp = tempfile.mkstemp(
            dir=str(self.path.parent or Path(".")), prefix=".creds-", suffix=".tmp"
        )
        try:
            with os.fdopen(fd, "w", encoding="utf-8") as f:
                f.write(payload)
            os.replace(tmp, self.path)
        except Exception:
            if os.path.exists(tmp):
                os.unlink(tmp)
            raise

    def get_login_token(self) -> str | None:
        return self.load().login_token

    def save_takeover(self, result, login_token: str) -> None:
        creds = self.load()
        creds.login_token = login_token
        creds.user_id = result.user_id
        creds.user_name = result.name
        creds.rank = result.rank
        self.save(creds)

    def save_api_token(self, token: str) -> None:
        creds = self.load()
        creds.api_token = token
        creds.api_token_exp = parse_jwt_exp(token)
        self.save(creds)

    def clear(self) -> None:
        if self.path.exists():
            self.path.unlink()
