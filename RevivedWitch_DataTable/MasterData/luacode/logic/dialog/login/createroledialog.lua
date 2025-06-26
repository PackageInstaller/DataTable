-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/createroledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local MaxWordCount, MinWordCount = ((NekoData.BehaviorManager).BM_Game):GetUpAndDownLimitsByFuncId((DataCommon.TextLimit).CharacterName)
local SShieldFunctionDef = (LuaNetManager.GetProtocolDef)("protocol.notify.sshieldfunction")
local CreateRoleDialog = class("CreateRoleDialog", Dialog)
CreateRoleDialog.AssetBundleName = "ui/layouts.createrole"
CreateRoleDialog.AssetName = "CreateRole"
CreateRoleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CreateRoleDialog
  ((CreateRoleDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._tag = false
end

CreateRoleDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, MinWordCount, MaxWordCount
  (self:GetChild("Back2/Textnew1")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1566, {MinWordCount, MaxWordCount}))
  self._username = self:GetChild("InputField")
  self._confirm = self:GetChild("Confirm")
  ;
  (self._confirm):Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  ;
  (self._username):Subscribe_PointerClickEvent(self.OnUsernameInputFieldClicked, self)
  self:OnShieldFunction()
  local crandomName = (LuaNetManager.CreateProtocol)("protocol.user.crandomname")
  if crandomName then
    crandomName:Send()
  end
  self._task = (GameTimer.AddTask)(0.5, 0, function()
    -- function num : 0_1_0 , upvalues : self
    self._task = nil
    self._tag = true
  end
, nil)
  local jsonStr = (JSON.encode)({eventName = "event", id = "3"})
  ;
  (ThinkingAnalyticsInterface.UploadEvent_TA)(jsonStr)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnShieldFunction, Common.n_ShieldFunction, nil)
end

CreateRoleDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

CreateRoleDialog.OnShieldFunction = function(self)
  -- function num : 0_3 , upvalues : _ENV, SShieldFunctionDef, CVarConfig
  local shield = ((NekoData.BehaviorManager).BM_Game):IsShieldFunction(SShieldFunctionDef.NAMING) or not ((NekoData.BehaviorManager).BM_Game):IsGuest() or (CVarConfig:GetRecorder(91)).Value == "0"
  ;
  (self._username):SetInteractable(not shield)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

CreateRoleDialog.SetRoleRandomName = function(self, protocol)
  -- function num : 0_4
  (self._username):SetText(protocol.name)
end

CreateRoleDialog.OnConfirmClick = function(self, args)
  -- function num : 0_5 , upvalues : _ENV
  if self._tag then
    local roleName = (self._username):GetText()
    local ccreateUser = (LuaNetManager.CreateProtocol)("protocol.user.ccreateuser")
    if ccreateUser then
      ccreateUser.name = roleName
      ccreateUser:Send()
    end
  end
end

CreateRoleDialog.OnUsernameInputFieldClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV, SShieldFunctionDef, CVarConfig
  if ((NekoData.BehaviorManager).BM_Game):IsShieldFunction(SShieldFunctionDef.NAMING) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100325)
  else
    if ((NekoData.BehaviorManager).BM_Game):IsGuest() and (CVarConfig:GetRecorder(91)).Value == "0" then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100335)
    end
  end
end

return CreateRoleDialog

