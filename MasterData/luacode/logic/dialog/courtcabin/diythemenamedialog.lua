local MaxWordCount, MinWordCount = NekoData.BehaviorManager.BM_Game:GetUpAndDownLimitsByFuncId(DataCommon.TextLimit.DIYThemeName)
local DiyThemeNameDialog = class("DiyThemeNameDialog", Dialog)
DiyThemeNameDialog.AssetBundleName = "ui/layouts.yard"
DiyThemeNameDialog.AssetName = "HouseAddTheme"

function DiyThemeNameDialog:Ctor(...)
  DiyThemeNameDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function DiyThemeNameDialog:OnCreate()
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
  self:Init()
end

function DiyThemeNameDialog:OnDestroy()
end

function DiyThemeNameDialog:Init()
  self._name:SetText(NekoData.BehaviorManager.BM_Cabin:GetName())
  self:OnNameUpdate()
end

function DiyThemeNameDialog:SetFunctionTag(tag)
  self._tag = tag
  if self._tag == "Change" then
    self._addThemeTxt:SetActive(false)
    self._changeThemeTxt:SetActive(true)
  elseif self._tag == "Add" then
    self._addThemeTxt:SetActive(true)
    self._changeThemeTxt:SetActive(false)
  end
end

function DiyThemeNameDialog:OnNameUpdate()
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

function DiyThemeNameDialog:OnBackBtnClicked()
  self:Destroy()
end

function DiyThemeNameDialog:OnConfirmBtnClicked()
  if self._tag == "Change" then
  elseif self._tag == "Add" then
  end
end

return DiyThemeNameDialog
