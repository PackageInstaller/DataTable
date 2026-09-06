local MaxWordCount, MinWordCount = NekoData.BehaviorManager.BM_Game:GetUpAndDownLimitsByFuncId(DataCommon.TextLimit.DIYThemeName)
local ChangeDiyThemeNameDialog = class("ChangeDiyThemeNameDialog", Dialog)
ChangeDiyThemeNameDialog.AssetBundleName = "ui/layouts.yard"
ChangeDiyThemeNameDialog.AssetName = "HouseAddTheme"

function ChangeDiyThemeNameDialog:Ctor(...)
  ChangeDiyThemeNameDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function ChangeDiyThemeNameDialog:OnCreate()
  self._addThemeTxt = self:GetChild("Back/Title")
  self._changeThemeTxt = self:GetChild("Back/Title2")
  self._name = self:GetChild("Back/InputField")
  self._inputTextNum = self:GetChild("Back/Textnew1")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self:GetChild("Back/Txt1"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1573, {MinWordCount, MaxWordCount}))
  self._name:Subscribe_ValueChangedEvent(self.OnNameUpdate, self)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._addThemeTxt:SetActive(false)
  self._changeThemeTxt:SetActive(true)
  self:OnNameUpdate()
end

function ChangeDiyThemeNameDialog:OnDestroy()
end

function ChangeDiyThemeNameDialog:Init(themeInfo)
  self._themeKey = themeInfo.key
  self._name:SetText(themeInfo.name)
end

function ChangeDiyThemeNameDialog:OnNameUpdate()
  local name = self._name:GetText()
  name = string.trim(name)
  self._changeName = name
  local count = utf8.len(name)
  if count > MaxWordCount then
    self._inputTextNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1570, {count, MaxWordCount}))
  else
    self._inputTextNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1569, {count, MaxWordCount}))
  end
end

function ChangeDiyThemeNameDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChangeDiyThemeNameDialog:OnConfirmBtnClicked()
  local cchangeThemeName = LuaNetManager.CreateProtocol("protocol.yard.cchangethemename")
  cchangeThemeName.key = self._themeKey
  cchangeThemeName.name = self._changeName
  cchangeThemeName:Send()
end

return ChangeDiyThemeNameDialog
