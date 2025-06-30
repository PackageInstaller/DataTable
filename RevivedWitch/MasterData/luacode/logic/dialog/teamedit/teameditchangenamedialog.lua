-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/teamedit/teameditchangenamedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MaxWordCount, MinWordCount = ((NekoData.BehaviorManager).BM_Game):GetUpAndDownLimitsByFuncId((DataCommon.TextLimit).TeamName)
local TeamEditChangeNameDialog = class("TeamEditChangeNameDialog", Dialog)
TeamEditChangeNameDialog.AssetBundleName = "ui/layouts.teamedit"
TeamEditChangeNameDialog.AssetName = "TeamEditChangeName"
TeamEditChangeNameDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TeamEditChangeNameDialog
  ((TeamEditChangeNameDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._name = nil
  self._changename = nil
end

TeamEditChangeNameDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, MaxWordCount
  self._teamName = self:GetChild("InputField")
  self._text = self:GetChild("Txtnew1")
  ;
  (self:GetChild("Textnew2")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1571, {MaxWordCount}))
  self._cancelBtn = self:GetChild("CancelBtn")
  self._confirmBtn = self:GetChild("ConfirmBtn")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._teamName):Subscribe_ValueChangedEvent(self.OnTeamNameUpdate, self)
end

TeamEditChangeNameDialog.OnDestroy = function(self)
  -- function num : 0_2
end

TeamEditChangeNameDialog.SetTeamName = function(self, name, teamId, istower)
  -- function num : 0_3
  self._isTower = istower
  self._name = name
  ;
  (self._teamName):SetText(name)
  self._teamId = teamId
end

TeamEditChangeNameDialog.OnTeamNameUpdate = function(self)
  -- function num : 0_4 , upvalues : _ENV, MaxWordCount
  local teamName = (self._teamName):GetText()
  teamName = (string.trim)(teamName)
  self._changename = teamName
  local count = (utf8.len)(teamName)
  if MaxWordCount < count then
    (self._text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1570, {count, MaxWordCount}))
  else
    ;
    (self._text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1569, {count, MaxWordCount}))
  end
  if teamName == "" or MaxWordCount < count then
    (self._confirmBtn):SetInteractable(false)
  else
    ;
    (self._confirmBtn):SetInteractable(true)
  end
end

TeamEditChangeNameDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("teamedit.teameditchangenamedialog")
end

TeamEditChangeNameDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._changename ~= self._name then
    local cchangeLineupName = (LuaNetManager.CreateProtocol)("protocol.login.cchangelineupname")
    if cchangeLineupName then
      cchangeLineupName.lineupId = self._teamId
      cchangeLineupName.name = self._changename
      cchangeLineupName:Send()
    end
    ;
    (DialogManager.DestroySingletonDialog)("teamedit.teameditchangenamedialog")
  else
    do
      self:Destroy()
    end
  end
end

return TeamEditChangeNameDialog

