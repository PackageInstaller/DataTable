local PhoneNum = require("logic.sdk.agent.phonenum")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local RegisterAccountDialog = class("RegisterAccountDialog", Dialog)
RegisterAccountDialog.AssetBundleName = "ui/layouts.login"
RegisterAccountDialog.AssetName = "LoginPhone"
local time = 60000

function RegisterAccountDialog:Ctor(...)
  RegisterAccountDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function RegisterAccountDialog:OnCreate()
  self._username = self:GetChild("InputPhone")
  self._sendVerCodeBtn = self:GetChild("SendBtn")
  self._timeCount = self:GetChild("CountBtn")
  self._timeCount:SetActive(false)
  self._timeTxt = self:GetChild("CountBtn/Num")
  self._verCodeInput = self:GetChild("InputCode")
  self._loginOnline = self:GetChild("ComfirmBtn")
  self._wrongPhoneTxt = self:GetChild("Text1")
  self._wrongPhoneTxt:SetActive(false)
  self._wrongCodeTxt = self:GetChild("Text2")
  self._wrongCodeTxt:SetActive(false)
  self._originalTxt = self._wrongCodeTxt:GetText()
  self._loginOnline:Subscribe_PointerClickEvent(self.OnLoginOnlineClicked, self)
  self._sendVerCodeBtn:Subscribe_PointerClickEvent(self.OnSendVerCodeBtnClicked, self)
  self._username:Subscribe_PointerClickEvent(self.OnPhoneNumClicked, self)
  self._verCodeInput:Subscribe_PointerClickEvent(self.OnInputCodeClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnHttpConnectedFailed, Common.n_HttpConnectedFailed, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRequestVerifyCodeResult, Common.n_PhoneRequestVerifyCodeResult, nil)
  LuaNotificationCenter.AddObserver(self, self.OnVerifyCodeWrong, Common.n_VerifyCodeWrong, nil)
end

function RegisterAccountDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function RegisterAccountDialog:OnLoginOnlineClicked(args)
  local phonestr = self._username:GetText()
  local codestr = self._verCodeInput:GetText()
  if not string.match(phonestr, "[1][3-9]%d%d%d%d%d%d%d%d%d") then
    self._wrongPhoneTxt:SetActive(true)
    return
  else
    self._wrongPhoneTxt:SetActive(false)
  end
  if codestr == "" then
    self._wrongCodeTxt:SetText(self._originalTxt)
    self._wrongCodeTxt:SetActive(true)
    return
  else
    self._wrongCodeTxt:SetActive(false)
  end
  PhoneNum.CheckPhonenumWithCode(phonestr, codestr)
end

function RegisterAccountDialog:OnSendVerCodeBtnClicked()
  self._wrongCodeTxt:SetActive(false)
  local num = self._username:GetText()
  if string.match(num, "^[1][3-9]%d%d%d%d%d%d%d%d%d") then
    self._sendVerCodeBtn:SetActive(false)
    self._timeCount:SetActive(true)
    time = 60000
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
    self._task = ServerGameTimer.AddTask(0, 1, function()
      self:RefreshSendCodeBtnState()
    end, nil)
    PhoneNum.RequestCode(num)
    self._wrongPhoneTxt:SetActive(false)
  else
    self._wrongPhoneTxt:SetActive(true)
  end
end

function RegisterAccountDialog:OnPhoneNumClicked()
  self._wrongPhoneTxt:SetActive(false)
  self._wrongCodeTxt:SetActive(false)
end

function RegisterAccountDialog:OnInputCodeClicked()
  self._wrongPhoneTxt:SetActive(false)
  self._wrongCodeTxt:SetActive(false)
end

function RegisterAccountDialog:RefreshSendCodeBtnState()
  time = time - 1000
  if time // 1000 > 0 then
    self._timeTxt:SetText("(" .. math.ceil(time / 1000) .. ")")
  else
    self._sendVerCodeBtn:SetActive(true)
    self._timeCount:SetActive(false)
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
    time = 60000
  end
end

function RegisterAccountDialog:OnHttpConnectedFailed(notification)
  self._wrongCodeTxt:SetText(notification.userInfo)
  self._wrongCodeTxt:SetActive(true)
  local dialog = DialogManager.CreateSingletonDialog("login.announcementdialog")
  if dialog then
    dialog:Init(dialog.Status.Close)
  end
end

function RegisterAccountDialog:OnRequestVerifyCodeResult(notification)
  if notification.userInfo == "false" then
    self._timeCount:SetActive(false)
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
    self._sendVerCodeBtn:SetActive(true)
  end
end

function RegisterAccountDialog:OnVerifyCodeWrong(notification)
  if notification.userInfo == "false" then
    self._wrongCodeTxt:SetText(self._originalTxt)
    self._wrongCodeTxt:SetActive(true)
  elseif notification.userInfo == "invalid" then
    local str = TextManager.GetText(CStringRes:GetRecorder(1102).msgTextID)
    self._wrongCodeTxt:SetText(str)
    self._wrongCodeTxt:SetActive(true)
  end
end

return RegisterAccountDialog
