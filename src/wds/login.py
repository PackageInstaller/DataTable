"""Login orchestration matching the game's title flow.

Game flow (captured in the 引继 HARs):

  1. no stored login token  -> 引继 (take-over) flow:
        POST /api/Account/GetTakeOverAccount {LinkageCode, Password}
        -> TakeOverAccountResult {IsSuccess, UserId, Name, Rank, LoginToken}
        the LoginToken (transition JWT) is persisted under the game's
        PlayerPrefs key "wEWm7nMyrRZe";
  2. POST /api/Account/Authenticate {LoginToken, GameVersion, ApkHash,
        ApkApplicationSignature, ApplicationVersion}
        -> AuthenticateResult {Token(Bearer), BanLevel, WarnedUntil};
  3. POST /api/Login {PushNotificationToken: nil} with the Bearer token
        -> LoginResult (user data).

The Bearer token is refreshed automatically when it is missing or expired.
"""

from __future__ import annotations

from dataclasses import dataclass

from .api import ApiClient, TakeOverAccountResult
from .token_store import Credentials, TokenStore


@dataclass(frozen=True)
class LoginSession:
    credentials: Credentials
    takeover: TakeOverAccountResult | None


class NeedsTakeOver(Exception):
    """Raised when a 引继 (take-over) credential must be supplied."""


class TakeOverFailed(RuntimeError):
    """Raised when the server rejects the 引继 ID/password."""


class LoginService:
    def __init__(
        self,
        api: ApiClient,
        store: TokenStore,
        *,
        apk_hash: str = "",
        apk_application_signature: str = "",
        app_version: str | None = None,
        authenticate_compressed: bool = False,
    ):
        self.api = api
        self.store = store
        self.apk_hash = apk_hash
        self.apk_application_signature = apk_application_signature
        self.app_version = app_version
        self.authenticate_compressed = authenticate_compressed

    # ---------------------------------------------------------- 引继 flow

    def takeover(
        self, linkage_code: str, password: str, *, persist: bool = True
    ) -> TakeOverAccountResult:
        """Import an account with 引继 ID + password (Japanese take-over codes)."""
        result = self.api.get_take_over_account(linkage_code, password)
        if not result.is_success or not result.login_token:
            raise TakeOverFailed(
                f"take-over rejected: user={result.user_id!r} name={result.name!r}"
            )
        if persist:
            self.store.save_takeover(result, result.login_token)
        return result

    # ------------------------------------------------------- token handling

    def ensure_login_token(
        self, linkage_code: str | None = None, password: str | None = None
    ) -> tuple[str, TakeOverAccountResult | None]:
        creds = self.store.load()
        if creds.has_login_token():
            return creds.login_token or "", None
        if not linkage_code or not password:
            raise NeedsTakeOver(
                "no login token stored; provide --linkage-code and --password"
            )
        result = self.takeover(linkage_code, password)
        return result.login_token or "", result

    def get_api_token(self, login_token: str) -> str:
        creds = self.store.load()
        if creds.has_valid_api_token():
            return creds.api_token or ""
        auth = self.api.authenticate(
            login_token,
            apk_hash=self.apk_hash,
            apk_application_signature=self.apk_application_signature,
            app_version=self.app_version,
            compressed=self.authenticate_compressed,
        )
        self.store.save_api_token(auth.token)
        return auth.token

    # ------------------------------------------------------------ login

    def login(
        self,
        linkage_code: str | None = None,
        password: str | None = None,
        *,
        persist: bool = True,
    ) -> LoginSession:
        login_token, takeover = self.ensure_login_token(linkage_code, password)
        api_token = self.get_api_token(login_token)
        self.api.login(api_token)  # completes the in-game login
        creds = self.store.load()
        if not creds.api_token:
            creds.api_token = api_token
            if persist:
                self.store.save(creds)
        return LoginSession(credentials=creds, takeover=takeover)
