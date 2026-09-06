local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local MaxWordCount, MinWordCount = NekoData.BehaviorManager.BM_Game:GetUpAndDownLimitsByFuncId(DataCommon.TextLimit.CharacterName)
local ChangeNameDialog = class("ChangeNameDialog", Dialog)
ChangeNameDialog.AssetBundleName = "ui/layouts.setting"
ChangeNameDialog.AssetName = "SettingChangeName"

function ChangeNameDialog:Ctor(...)
  ChangeNameDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function ChangeNameDialog:OnCreate()
  self._username = self:GetChild("InputField")
  self:GetChild("Back2/Textnew1"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1566, {MinWordCount, MaxWordCount}))
  self._cancle = self:GetChild("Cancel")
  self._confirm = self:GetChild("Confirm")
  self._cancle:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirm:Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  self._username:SetText(tostring(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username))
end

function ChangeNameDialog:OnDestroy()
end

function ChangeNameDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChangeNameDialog:OnConfirmClick(args)
  if NekoData.BehaviorManager.BM_Game:IsGuest() and CVarConfig:GetRecorder(91).Value == "0" then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100335)
    return
  end
  local ccreateUser = LuaNetManager.CreateProtocol("protocol.user.cchangeusername")
  if ccreateUser then
    ccreateUser.name = self._username:GetText()
    ccreateUser:Send()
  end
end

return ChangeNameDialog
