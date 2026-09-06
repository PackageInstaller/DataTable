local MaxWordCount, MinWordCount = NekoData.BehaviorManager.BM_Game:GetUpAndDownLimitsByFuncId(DataCommon.TextLimit.TeamName)
local TeamEditChangeNameDialog = class("TeamEditChangeNameDialog", Dialog)
TeamEditChangeNameDialog.AssetBundleName = "ui/layouts.teamedit"
TeamEditChangeNameDialog.AssetName = "TeamEditChangeName"

function TeamEditChangeNameDialog:Ctor(...)
  TeamEditChangeNameDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._name = nil
  self._changename = nil
end

function TeamEditChangeNameDialog:OnCreate()
  self._teamName = self:GetChild("InputField")
  self._text = self:GetChild("Txtnew1")
  self:GetChild("Textnew2"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1571, {MaxWordCount}))
  self._cancelBtn = self:GetChild("CancelBtn")
  self._confirmBtn = self:GetChild("ConfirmBtn")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._teamName:Subscribe_ValueChangedEvent(self.OnTeamNameUpdate, self)
end

function TeamEditChangeNameDialog:OnDestroy()
end

function TeamEditChangeNameDialog:SetTeamName(name, teamId, istower)
  self._isTower = istower
  self._name = name
  self._teamName:SetText(name)
  self._teamId = teamId
end

function TeamEditChangeNameDialog:OnTeamNameUpdate()
  local teamName = self._teamName:GetText()
  teamName = string.trim(teamName)
  self._changename = teamName
  local count = utf8.len(teamName)
  if count > MaxWordCount then
    self._text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1570, {count, MaxWordCount}))
  else
    self._text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1569, {count, MaxWordCount}))
  end
  if teamName == "" or count > MaxWordCount then
    self._confirmBtn:SetInteractable(false)
  else
    self._confirmBtn:SetInteractable(true)
  end
end

function TeamEditChangeNameDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("teamedit.teameditchangenamedialog")
end

function TeamEditChangeNameDialog:OnConfirmBtnClicked()
  if self._changename ~= self._name then
    local cchangeLineupName = LuaNetManager.CreateProtocol("protocol.login.cchangelineupname")
    if cchangeLineupName then
      cchangeLineupName.lineupId = self._teamId
      cchangeLineupName.name = self._changename
      cchangeLineupName:Send()
    end
    DialogManager.DestroySingletonDialog("teamedit.teameditchangenamedialog")
  else
    self:Destroy()
  end
end

return TeamEditChangeNameDialog
