local SoundLoginDialog = class("SoundLoginDialog", Dialog)
SoundLoginDialog.AssetBundleName = "ui/layouts.login"
SoundLoginDialog.AssetName = "LoginDialogSound"

function SoundLoginDialog:Ctor(...)
  SoundLoginDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function SoundLoginDialog:OnCreate()
  self._username = self:GetChild("InputField")
  self._loginOnline = self:GetChild("LoginOnline")
  self._loginOnline:Subscribe_PointerClickEvent(self.OnLoginOnlineClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnLoginResult, Common.n_LoginResult, nil)
  LuaNotificationCenter.AddObserver(self, self.OnMainConnectException, Common.n_MainConnectException, nil)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(1)
  self._username:SetText(CS.UnityEngine.PlayerPrefs.GetString("loginAccount"))
end

function SoundLoginDialog:OnDestroy()
  UIBackManager.SetUIBackShow(false)
  LuaNotificationCenter.RemoveObserver(self)
end

function SoundLoginDialog:OnLoginOnlineClicked(args)
  local username = self._username:GetText()
  username = string.trim(username)
  if username ~= "" then
    CS.UnityEngine.PlayerPrefs.SetString("loginAccount", username)
    CS.PixelNeko.P1.PlatformManager.Login(JSON.encode({
      host = client_server_list[1].domain,
      port = client_server_list[1].port,
      account = username
    }))
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100003)
  end
end

function SoundLoginDialog:OnMainConnectException(noti)
  NekoData.BehaviorManager.BM_Message:AddMessageTip(noti.userInfo:GetException())
end

function SoundLoginDialog:OnLoginResult(notification)
  local resultJson = JSON.decode(notification.userInfo)
  LuaNetManager.ConnectToServer(resultJson.host, resultJson.port, resultJson.account, "", "apps")
end

return SoundLoginDialog
