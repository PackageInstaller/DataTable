local IdentityCell = class("IdentityCell", Dialog)
IdentityCell.AssetBundleName = "ui/layouts.setting"
IdentityCell.AssetName = "SettingIdentity"

function IdentityCell:Ctor(...)
  IdentityCell.super.Ctor(self, ...)
end

function IdentityCell:OnCreate()
  self._phoneBindBtn = self:GetChild("Phone/Btn")
  self._phoneBindBefore = self:GetChild("Phone/Before")
  self._phoneBindAfter = self:GetChild("Phone/After")
  self._phoneBindAfterTxt = self:GetChild("Phone/After/Txt")
  self._mailboxBindBtn = self:GetChild("Mail/Btn")
  self._mailboxBindBefore = self:GetChild("Mail/Before")
  self._mailboxBindAfter = self:GetChild("Mail/After")
  self._mailboxBindAfterTxt = self:GetChild("Mail/After/Txt")
  self._service = self:GetChild("Service")
  self._service:SetActive(false)
  if SdkManager.GetChannel() == "leit" then
    if SdkManager.GetAgent():IsChannelPackage() then
      local phoneBindAnchoredx, phoneBindAnchoredy = self:GetChild("Phone"):GetAnchoredPosition()
      self:GetChild("Phone"):SetActive(false)
      self:GetChild("Mail"):SetActive(false)
      self:GetChild("Number"):SetAnchoredPosition(phoneBindAnchoredx, phoneBindAnchoredy)
    else
      self._service:SetActive(true)
      self:GetChild("Service/Btn"):Subscribe_PointerClickEvent(self.OnServiceClick, self)
    end
  end
  self._codeview = self:GetChild("Number")
  self._codeview:SetActive(not global_var_local_check)
  self._code = self:GetChild("Number/Btn")
  self._code:Subscribe_PointerClickEvent(self.OnCodeBtnClicked, self)
  self._phoneBindBtn:Subscribe_PointerClickEvent(self.OnPhoneBindBtnClicked, self)
  self._mailboxBindBtn:Subscribe_PointerClickEvent(self.OnMailboxBindBtnClicked, self)
end

function IdentityCell:OnDestroy()
end

function IdentityCell:RefreshCell()
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  if userInfo.phoneNum == "" then
    self._phoneBindBefore:SetActive(true)
    self._phoneBindAfter:SetActive(false)
    self._phoneBindBtn:SetActive(true)
  else
    self._phoneBindBefore:SetActive(false)
    self._phoneBindAfter:SetActive(true)
    self._phoneBindBtn:SetActive(false)
    self._phoneBindAfterTxt:SetText(userInfo.phoneNum)
  end
  if userInfo.mailAddr == "" then
    self._mailboxBindBefore:SetActive(true)
    self._mailboxBindAfter:SetActive(false)
    self._mailboxBindBtn:SetActive(true)
  else
    self._mailboxBindBefore:SetActive(false)
    self._mailboxBindAfter:SetActive(true)
    self._mailboxBindBtn:SetActive(false)
    self._mailboxBindAfterTxt:SetText(userInfo.mailAddr)
  end
end

function IdentityCell:OnPhoneBindBtnClicked()
  local crefreshphonecdtime = LuaNetManager.CreateProtocol("protocol.user.crefreshphonecdtime")
  if crefreshphonecdtime then
    crefreshphonecdtime:Send()
  end
  DialogManager.CreateSingletonDialog("systemsetting.phonebinddialog")
end

function IdentityCell:OnMailboxBindBtnClicked()
  local crefreshmailcdtime = LuaNetManager.CreateProtocol("protocol.user.crefreshmailcdtime")
  if crefreshmailcdtime then
    crefreshmailcdtime:Send()
  end
  DialogManager.CreateSingletonDialog("systemsetting.mailboxbinddialog")
end

function IdentityCell:OnCodeBtnClicked()
  DialogManager.CreateSingletonDialog("systemsetting.code.codedialog")
end

function IdentityCell:OnServiceClick()
  SdkManager.GetAgent():ShowCustomerService("")
end

return IdentityCell
