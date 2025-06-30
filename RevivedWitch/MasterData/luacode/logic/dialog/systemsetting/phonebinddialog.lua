-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/phonebinddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CBindingCfg = (BeanManager.GetTableByName)("setting.cbindingcfg")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local PhoneBindDialog = class("PhoneBindDialog", Dialog)
PhoneBindDialog.AssetBundleName = "ui/layouts.setting"
PhoneBindDialog.AssetName = "SettingPhone"
PhoneBindDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PhoneBindDialog
  ((PhoneBindDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._task = nil
end

PhoneBindDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : CBindingCfg, _ENV, CStringres, CImagePathTable, CItemAttrTable
  self._text = self:GetChild("Back/Text")
  self._moneyIcon = self:GetChild("Back/Money")
  self._phoneNumber = self:GetChild("Back/InputField1")
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
  local record = CBindingCfg:GetRecorder(1)
  ;
  (self._text):SetText((string.gsub)((TextManager.GetText)((CStringres:GetRecorder(1085)).msgTextID), "%$parameter1%$", record.itemNum))
  if not CImagePathTable:GetRecorder((CItemAttrTable:GetRecorder(record.item)).icon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._moneyIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self:Refresh()
end

PhoneBindDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

PhoneBindDialog.RefreshSendCodeBtnState = function(self)
  -- function num : 0_3 , upvalues : _ENV, CStringres
  local phoneCodeState = ((NekoData.BehaviorManager).BM_Game):GetPhoneCodeState()
  local time = phoneCodeState.time - (ServerGameTimer.GetServerTimeForecast)()
  if time // 1000 > 0 then
    local str = ""
    if phoneCodeState.tag == 1 then
      str = (string.gsub)((TextManager.GetText)((CStringres:GetRecorder(1083)).msgTextID), "%$parameter1%$", (math.ceil)(time / 1000))
    else
      if phoneCodeState.tag == 2 then
        str = (string.gsub)((TextManager.GetText)((CStringres:GetRecorder(1084)).msgTextID), "%$parameter1%$", (os.date)("!%H", time // 1000))
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

PhoneBindDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local phoneCodeState = ((NekoData.BehaviorManager).BM_Game):GetPhoneCodeState()
  if not phoneCodeState.tag then
    (self._sendCodeBtn):SetInteractable(true)
    ;
    (self._codeTxt):SetActive(true)
    ;
    (self._timeTxt):SetActive(false)
    return 
  end
  if phoneCodeState.tag == 0 then
    (self._sendCodeBtn):SetInteractable(true)
    ;
    (self._codeTxt):SetActive(true)
    ;
    (self._timeTxt):SetActive(false)
  else
    local time = phoneCodeState.time - (ServerGameTimer.GetServerTimeForecast)()
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

PhoneBindDialog.OnSendCodeBtn = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local csendPhoneCode = (LuaNetManager.CreateProtocol)("protocol.user.csendphonecode")
  if csendPhoneCode then
    csendPhoneCode.phoneNum = (self._phoneNumber):GetText()
    csendPhoneCode:Send()
  end
end

PhoneBindDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

PhoneBindDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local str = (self._identifyCode):GetText()
  if str == "" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100057)
  else
    local ccheckPhoneCode = (LuaNetManager.CreateProtocol)("protocol.user.ccheckphonecode")
    if ccheckPhoneCode then
      ccheckPhoneCode.code = (self._identifyCode):GetText()
      ccheckPhoneCode:Send()
    end
  end
end

return PhoneBindDialog

