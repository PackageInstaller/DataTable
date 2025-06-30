-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/registeraccountdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PhoneNum = require("logic.sdk.agent.phonenum")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local RegisterAccountDialog = class("RegisterAccountDialog", Dialog)
RegisterAccountDialog.AssetBundleName = "ui/layouts.login"
RegisterAccountDialog.AssetName = "LoginPhone"
local time = 60000
RegisterAccountDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RegisterAccountDialog
  ((RegisterAccountDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

RegisterAccountDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._username = self:GetChild("InputPhone")
  self._sendVerCodeBtn = self:GetChild("SendBtn")
  self._timeCount = self:GetChild("CountBtn")
  ;
  (self._timeCount):SetActive(false)
  self._timeTxt = self:GetChild("CountBtn/Num")
  self._verCodeInput = self:GetChild("InputCode")
  self._loginOnline = self:GetChild("ComfirmBtn")
  self._wrongPhoneTxt = self:GetChild("Text1")
  ;
  (self._wrongPhoneTxt):SetActive(false)
  self._wrongCodeTxt = self:GetChild("Text2")
  ;
  (self._wrongCodeTxt):SetActive(false)
  self._originalTxt = (self._wrongCodeTxt):GetText()
  ;
  (self._loginOnline):Subscribe_PointerClickEvent(self.OnLoginOnlineClicked, self)
  ;
  (self._sendVerCodeBtn):Subscribe_PointerClickEvent(self.OnSendVerCodeBtnClicked, self)
  ;
  (self._username):Subscribe_PointerClickEvent(self.OnPhoneNumClicked, self)
  ;
  (self._verCodeInput):Subscribe_PointerClickEvent(self.OnInputCodeClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnHttpConnectedFailed, Common.n_HttpConnectedFailed, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRequestVerifyCodeResult, Common.n_PhoneRequestVerifyCodeResult, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnVerifyCodeWrong, Common.n_VerifyCodeWrong, nil)
end

RegisterAccountDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

RegisterAccountDialog.OnLoginOnlineClicked = function(self, args)
  -- function num : 0_3 , upvalues : _ENV, PhoneNum
  local phonestr = (self._username):GetText()
  local codestr = (self._verCodeInput):GetText()
  if not (string.match)(phonestr, "[1][3-9]%d%d%d%d%d%d%d%d%d") then
    (self._wrongPhoneTxt):SetActive(true)
    return 
  else
    ;
    (self._wrongPhoneTxt):SetActive(false)
  end
  if codestr == "" then
    (self._wrongCodeTxt):SetText(self._originalTxt)
    ;
    (self._wrongCodeTxt):SetActive(true)
    return 
  else
    ;
    (self._wrongCodeTxt):SetActive(false)
  end
  ;
  (PhoneNum.CheckPhonenumWithCode)(phonestr, codestr)
end

RegisterAccountDialog.OnSendVerCodeBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, time, PhoneNum
  (self._wrongCodeTxt):SetActive(false)
  local num = (self._username):GetText()
  if (string.match)(num, "^[1][3-9]%d%d%d%d%d%d%d%d%d") then
    (self._sendVerCodeBtn):SetActive(false)
    ;
    (self._timeCount):SetActive(true)
    time = 60000
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
    self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_4_0 , upvalues : self
    self:RefreshSendCodeBtnState()
  end
, nil)
    ;
    (PhoneNum.RequestCode)(num)
    ;
    (self._wrongPhoneTxt):SetActive(false)
  else
    ;
    (self._wrongPhoneTxt):SetActive(true)
  end
end

RegisterAccountDialog.OnPhoneNumClicked = function(self)
  -- function num : 0_5
  (self._wrongPhoneTxt):SetActive(false)
  ;
  (self._wrongCodeTxt):SetActive(false)
end

RegisterAccountDialog.OnInputCodeClicked = function(self)
  -- function num : 0_6
  (self._wrongPhoneTxt):SetActive(false)
  ;
  (self._wrongCodeTxt):SetActive(false)
end

RegisterAccountDialog.RefreshSendCodeBtnState = function(self)
  -- function num : 0_7 , upvalues : time, _ENV
  time = time - 1000
  if time // 1000 > 0 then
    (self._timeTxt):SetText("(" .. (math.ceil)(time / 1000) .. ")")
  else
    ;
    (self._sendVerCodeBtn):SetActive(true)
    ;
    (self._timeCount):SetActive(false)
    ;
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
    time = 60000
  end
end

RegisterAccountDialog.OnHttpConnectedFailed = function(self, notification)
  -- function num : 0_8 , upvalues : _ENV
  (self._wrongCodeTxt):SetText(notification.userInfo)
  ;
  (self._wrongCodeTxt):SetActive(true)
  local dialog = (DialogManager.CreateSingletonDialog)("login.announcementdialog")
  if dialog then
    dialog:Init((dialog.Status).Close)
  end
end

RegisterAccountDialog.OnRequestVerifyCodeResult = function(self, notification)
  -- function num : 0_9 , upvalues : _ENV
  if notification.userInfo == "false" then
    (self._timeCount):SetActive(false)
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
    ;
    (self._sendVerCodeBtn):SetActive(true)
  end
end

RegisterAccountDialog.OnVerifyCodeWrong = function(self, notification)
  -- function num : 0_10 , upvalues : _ENV, CStringRes
  if notification.userInfo == "false" then
    (self._wrongCodeTxt):SetText(self._originalTxt)
    ;
    (self._wrongCodeTxt):SetActive(true)
  else
    if notification.userInfo == "invalid" then
      local str = (TextManager.GetText)((CStringRes:GetRecorder(1102)).msgTextID)
      ;
      (self._wrongCodeTxt):SetText(str)
      ;
      (self._wrongCodeTxt):SetActive(true)
    end
  end
end

return RegisterAccountDialog

