local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local MaxWordCount, MinWordCount = NekoData.BehaviorManager.BM_Game:GetUpAndDownLimitsByFuncId(DataCommon.TextLimit.CharacterName)
local SShieldFunctionDef = LuaNetManager.GetProtocolDef("protocol.notify.sshieldfunction")
local CreateRoleDialog = class("CreateRoleDialog", Dialog)
CreateRoleDialog.AssetBundleName = "ui/layouts.createrole"
CreateRoleDialog.AssetName = "CreateRole"

function CreateRoleDialog:Ctor(...)
  CreateRoleDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._tag = false
end

function CreateRoleDialog:OnCreate()
  self:GetChild("Back2/Textnew1"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1566, {MinWordCount, MaxWordCount}))
  self._username = self:GetChild("InputField")
  self._confirm = self:GetChild("Confirm")
  self._confirm:Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  self._username:Subscribe_PointerClickEvent(self.OnUsernameInputFieldClicked, self)
  self:OnShieldFunction()
  local crandomName = LuaNetManager.CreateProtocol("protocol.user.crandomname")
  if crandomName then
    crandomName:Send()
  end
  self._task = GameTimer.AddTask(0.5, 0, function()
    self._task = nil
    self._tag = true
  end, nil)
  local jsonStr = JSON.encode({eventName = "event", id = "3"})
  ThinkingAnalyticsInterface.UploadEvent_TA(jsonStr)
  LuaNotificationCenter.AddObserver(self, self.OnShieldFunction, Common.n_ShieldFunction, nil)
end

function CreateRoleDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function CreateRoleDialog:OnShieldFunction()
  local shield = NekoData.BehaviorManager.BM_Game:IsShieldFunction(SShieldFunctionDef.NAMING) or NekoData.BehaviorManager.BM_Game:IsGuest() and CVarConfig:GetRecorder(91).Value == "0"
  self._username:SetInteractable(not shield)
end

function CreateRoleDialog:SetRoleRandomName(protocol)
  self._username:SetText(protocol.name)
end

function CreateRoleDialog:OnConfirmClick(args)
  if self._tag then
    local roleName = self._username:GetText()
    local ccreateUser = LuaNetManager.CreateProtocol("protocol.user.ccreateuser")
    if ccreateUser then
      ccreateUser.name = roleName
      ccreateUser:Send()
    end
  end
end

function CreateRoleDialog:OnUsernameInputFieldClicked()
  if NekoData.BehaviorManager.BM_Game:IsShieldFunction(SShieldFunctionDef.NAMING) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100325)
  elseif NekoData.BehaviorManager.BM_Game:IsGuest() and CVarConfig:GetRecorder(91).Value == "0" then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100335)
  end
end

return CreateRoleDialog
