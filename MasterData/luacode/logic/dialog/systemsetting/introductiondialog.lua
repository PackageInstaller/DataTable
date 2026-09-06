local CVarConfigTable = BeanManager.GetTableByName("var.cvarconfig")
local MaxWordCount, MinWordCount = NekoData.BehaviorManager.BM_Game:GetUpAndDownLimitsByFuncId(DataCommon.TextLimit.CharacterIntroduction)
local IntroductionDialog = class("IntroductionDialog", Dialog)
IntroductionDialog.AssetBundleName = "ui/layouts.setting"
IntroductionDialog.AssetName = "SettingIntroduction"

function IntroductionDialog:Ctor(...)
  IntroductionDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._curIntroduction = ""
  self._changeIntroduction = ""
end

function IntroductionDialog:OnCreate()
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._introduction = self:GetChild("Back/IntroductionInputField")
  self._text = self:GetChild("Back/Txtnew1")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._introduction:Subscribe_ValueChangedEvent(self.OnIntroductionUpdate, self)
  self:Init()
end

function IntroductionDialog:OnDestroy()
end

function IntroductionDialog:Init()
  self._curIntroduction = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().introduce
  self._introduction:SetText(self._curIntroduction)
  self._changeIntroduction = self._curIntroduction
  local wordCount = utf8.len(self._curIntroduction)
  self._text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1569, {wordCount, MaxWordCount}))
end

function IntroductionDialog:OnIntroductionUpdate()
  self._changeIntroduction = string.trim(self._introduction:GetText())
  local wordCount = utf8.len(self._changeIntroduction)
  if wordCount > MaxWordCount then
    self._text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1570, {wordCount, MaxWordCount}))
  else
    self._text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1569, {wordCount, MaxWordCount}))
  end
end

function IntroductionDialog:OnBackBtnClicked()
  self:Destroy()
end

function IntroductionDialog:OnConfirmBtnClicked()
  if NekoData.BehaviorManager.BM_Game:IsGuest() and CVarConfigTable:GetRecorder(96).Value == "0" then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100340)
    return
  end
  local wordCount = utf8.len(self._changeIntroduction)
  if wordCount > MaxWordCount then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100034, {MaxWordCount})
  elseif self._changeIntroduction ~= self._curIntroduction then
    local cchangeuserintroduce = LuaNetManager.CreateProtocol("protocol.user.cchangeuserintroduce")
    if cchangeuserintroduce then
      cchangeuserintroduce.introduce = self._changeIntroduction
      cchangeuserintroduce:Send()
    end
  else
    self:Destroy()
  end
end

return IntroductionDialog
