-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/soundlogindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SoundLoginDialog = class("SoundLoginDialog", Dialog)
SoundLoginDialog.AssetBundleName = "ui/layouts.login"
SoundLoginDialog.AssetName = "LoginDialogSound"
SoundLoginDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SoundLoginDialog
  ((SoundLoginDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

SoundLoginDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._username = self:GetChild("InputField")
  self._loginOnline = self:GetChild("LoginOnline")
  ;
  (self._loginOnline):Subscribe_PointerClickEvent(self.OnLoginOnlineClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLoginResult, Common.n_LoginResult, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnMainConnectException, Common.n_MainConnectException, nil)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(1)
  ;
  (self._username):SetText((((CS.UnityEngine).PlayerPrefs).GetString)("loginAccount"))
end

SoundLoginDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(false)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

SoundLoginDialog.OnLoginOnlineClicked = function(self, args)
  -- function num : 0_3 , upvalues : _ENV
  local username = (self._username):GetText()
  username = (string.trim)(username)
  if username ~= "" then
    (((CS.UnityEngine).PlayerPrefs).SetString)("loginAccount", username)
    ;
    ((((CS.PixelNeko).P1).PlatformManager).Login)((JSON.encode)({host = (client_server_list[1]).domain, port = (client_server_list[1]).port, account = username}))
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100003)
  end
end

SoundLoginDialog.OnMainConnectException = function(self, noti)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddMessageTip((noti.userInfo):GetException())
end

SoundLoginDialog.OnLoginResult = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local resultJson = (JSON.decode)(notification.userInfo)
  ;
  (LuaNetManager.ConnectToServer)(resultJson.host, resultJson.port, resultJson.account, "", "apps")
end

return SoundLoginDialog

