local CStringres = BeanManager.GetTableByName("message.cstringres")
local CBindingCfg = BeanManager.GetTableByName("setting.cbindingcfg")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local PhoneBindDialog = class("PhoneBindDialog", Dialog)
PhoneBindDialog.AssetBundleName = "ui/layouts.setting"
PhoneBindDialog.AssetName = "SettingPhone"

function PhoneBindDialog:Ctor(...)
  PhoneBindDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._task = nil
end

function PhoneBindDialog:OnCreate()
  self._text = self:GetChild("Back/Text")
  self._moneyIcon = self:GetChild("Back/Money")
  self._phoneNumber = self:GetChild("Back/InputField1")
  self._identifyCode = self:GetChild("Back/InputField2")
  self._sendCodeBtn = self:GetChild("Back/CloseBtn")
  self._codeTxt = self:GetChild("Back/CloseBtn/_Text")
  self._timeTxt = self:GetChild("Back/CloseBtn/Time")
  self._cancelButton = self:GetChild("Back/CancelButton")
  self._confirmButton = self:GetChild("Back/ConfirmButton")
  self._sendCodeBtn:Subscribe_PointerClickEvent(self.OnSendCodeBtn, self)
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
  local record = CBindingCfg:GetRecorder(1)
  self._text:SetText(string.gsub(TextManager.GetText(CStringres:GetRecorder(1085).msgTextID), "%$parameter1%$", record.itemNum))
  local imageRecord = CImagePathTable:GetRecorder(CItemAttrTable:GetRecorder(record.item).icon) or DataCommon.DefaultImageAsset
  self._moneyIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self:Refresh()
end

function PhoneBindDialog:OnDestroy()
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function PhoneBindDialog:RefreshSendCodeBtnState()
  local phoneCodeState = NekoData.BehaviorManager.BM_Game:GetPhoneCodeState()
  local time = phoneCodeState.time - ServerGameTimer.GetServerTimeForecast()
  if time // 1000 > 0 then
    local str = ""
    if phoneCodeState.tag == 1 then
      str = string.gsub(TextManager.GetText(CStringres:GetRecorder(1083).msgTextID), "%$parameter1%$", math.ceil(time / 1000))
    elseif phoneCodeState.tag == 2 then
      str = string.gsub(TextManager.GetText(CStringres:GetRecorder(1084).msgTextID), "%$parameter1%$", os.date("!%H", time // 1000))
      str = string.gsub(str, "%$parameter2%$", os.date("!%M", time // 1000))
      str = string.gsub(str, "%$parameter3%$", os.date("!%S", time // 1000))
    end
    self._timeTxt:SetText(str)
  else
    self._sendCodeBtn:SetInteractable(true)
    self._codeTxt:SetActive(true)
    self._timeTxt:SetActive(false)
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function PhoneBindDialog:Refresh()
  local phoneCodeState = NekoData.BehaviorManager.BM_Game:GetPhoneCodeState()
  if not phoneCodeState.tag then
    self._sendCodeBtn:SetInteractable(true)
    self._codeTxt:SetActive(true)
    self._timeTxt:SetActive(false)
    return
  end
  if phoneCodeState.tag == 0 then
    self._sendCodeBtn:SetInteractable(true)
    self._codeTxt:SetActive(true)
    self._timeTxt:SetActive(false)
  else
    local time = phoneCodeState.time - ServerGameTimer.GetServerTimeForecast()
    if 0 < time // 1000 then
      self._sendCodeBtn:SetInteractable(false)
      self._codeTxt:SetActive(false)
      self._timeTxt:SetActive(true)
      self._task = GameTimer.AddTask(0, 1, function()
        self:RefreshSendCodeBtnState()
      end, nil)
    else
      self._sendCodeBtn:SetInteractable(true)
      self._codeTxt:SetActive(true)
      self._timeTxt:SetActive(false)
    end
  end
end

function PhoneBindDialog:OnSendCodeBtn()
  local csendPhoneCode = LuaNetManager.CreateProtocol("protocol.user.csendphonecode")
  if csendPhoneCode then
    csendPhoneCode.phoneNum = self._phoneNumber:GetText()
    csendPhoneCode:Send()
  end
end

function PhoneBindDialog:OnBackBtnClicked()
  self:Destroy()
end

function PhoneBindDialog:OnClickConfirmBtn()
  local str = self._identifyCode:GetText()
  if str == "" then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100057)
  else
    local ccheckPhoneCode = LuaNetManager.CreateProtocol("protocol.user.ccheckphonecode")
    if ccheckPhoneCode then
      ccheckPhoneCode.code = self._identifyCode:GetText()
      ccheckPhoneCode:Send()
    end
  end
end

return PhoneBindDialog
