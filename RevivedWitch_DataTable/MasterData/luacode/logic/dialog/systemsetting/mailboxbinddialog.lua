-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/mailboxbinddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CBindingCfg = (BeanManager.GetTableByName)("setting.cbindingcfg")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MailboxBindDialog = class("MailboxBindDialog", Dialog)
MailboxBindDialog.AssetBundleName = "ui/layouts.setting"
MailboxBindDialog.AssetName = "SettingMail"
MailboxBindDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MailboxBindDialog
  ((MailboxBindDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._task = nil
end

MailboxBindDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : CBindingCfg, _ENV, CStringres, CImagePathTable, CItemAttrTable
  self._text = self:GetChild("Back/Text")
  self._moneyIcon = self:GetChild("Back/Money")
  self._mailAddress = self:GetChild("Back/InputField1")
  self._identifyCode = self:GetChild("Back/InputField2")
  self._sendCodeBtn = self:GetChild("Back/CloseBtn")
  self._codeTxt = self:GetChild("Back/CloseBtn/_Text")
  self._timeTxt = self:GetChild("Back/CloseBtn/Time")
  self._cancelButton = self:GetChild("Back/CancelButton")
  self._confirmButton = self:GetChild("Back/ConfirmButton")
  ;
  (self._sendCodeBtn):Subscribe_PointerClickEvent(self.OnSendCodeBtn, self)
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
  local record = CBindingCfg:GetRecorder(2)
  local str = (TextManager.GetText)((CStringres:GetRecorder(1085)).msgTextID)
  ;
  (self._text):SetText((string.gsub)(str, "%$parameter1%$", record.itemNum))
  if not CImagePathTable:GetRecorder((CItemAttrTable:GetRecorder(record.item)).icon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._moneyIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self:Refresh()
end

MailboxBindDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

MailboxBindDialog.RefreshSendCodeBtnState = function(self)
  -- function num : 0_3 , upvalues : _ENV, CStringres
  local mailCodeState = ((NekoData.BehaviorManager).BM_Game):GetMailCodeState()
  local time = mailCodeState.time - (ServerGameTimer.GetServerTimeForecast)()
  if time // 1000 > 0 then
    local str = ""
    if mailCodeState.tag == 1 then
      str = (TextManager.GetText)((CStringres:GetRecorder(1083)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", (math.ceil)(time / 1000))
    else
      if mailCodeState.tag == 2 then
        str = (TextManager.GetText)((CStringres:GetRecorder(1084)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", time // 1000))
        str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", time // 1000))
        str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", time // 1000))
      end
    end
    ;
    (self._timeTxt):SetText(str)
  else
    do
      ;
      (self._sendCodeBtn):SetInteractable(true)
      ;
      (self._codeTxt):SetActive(true)
      ;
      (self._timeTxt):SetActive(false)
      ;
      (GameTimer.RemoveTask)(self._task)
      self._task = nil
    end
  end
end

MailboxBindDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local mailCodeState = ((NekoData.BehaviorManager).BM_Game):GetMailCodeState()
  if not mailCodeState.tag then
    (self._sendCodeBtn):SetInteractable(true)
    ;
    (self._codeTxt):SetActive(true)
    ;
    (self._timeTxt):SetActive(false)
    return 
  end
  if mailCodeState.tag == 0 then
    (self._sendCodeBtn):SetInteractable(true)
    ;
    (self._codeTxt):SetActive(true)
    ;
    (self._timeTxt):SetActive(false)
  else
    local time = mailCodeState.time - (ServerGameTimer.GetServerTimeForecast)()
    if time // 1000 > 0 then
      (self._sendCodeBtn):SetInteractable(false)
      ;
      (self._codeTxt):SetActive(false)
      ;
      (self._timeTxt):SetActive(true)
      self._task = (GameTimer.AddTask)(0, 1, function()
    -- function num : 0_4_0 , upvalues : self
    self:RefreshSendCodeBtnState()
  end
, nil)
    else
      ;
      (self._sendCodeBtn):SetInteractable(true)
      ;
      (self._codeTxt):SetActive(true)
      ;
      (self._timeTxt):SetActive(false)
    end
  end
end

MailboxBindDialog.OnSendCodeBtn = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local csendMailCode = (LuaNetManager.CreateProtocol)("protocol.user.csendmailcode")
  if csendMailCode then
    csendMailCode.address = (self._mailAddress):GetText()
    csendMailCode:Send()
  end
end

MailboxBindDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

MailboxBindDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local str = (self._identifyCode):GetText()
  if str == "" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100057)
  else
    local ccheckMailCode = (LuaNetManager.CreateProtocol)("protocol.user.ccheckmailcode")
    if ccheckMailCode then
      ccheckMailCode.code = (self._identifyCode):GetText()
      ccheckMailCode:Send()
    end
  end
end

return MailboxBindDialog

