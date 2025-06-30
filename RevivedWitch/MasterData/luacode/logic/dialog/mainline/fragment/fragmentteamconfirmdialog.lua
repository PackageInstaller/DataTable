-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/fragment/fragmentteamconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local FragmentTeamConfirmDialog = class("FragmentTeamConfirmDialog", Dialog)
FragmentTeamConfirmDialog.AssetBundleName = "ui/layouts.fragment"
FragmentTeamConfirmDialog.AssetName = "FragmentTeamConfirm"
FragmentTeamConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FragmentTeamConfirmDialog
  ((FragmentTeamConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

FragmentTeamConfirmDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._frameUI = self:GetChild("CellFrame")
  self._frame = (TableFrame.Create)(self._frameUI, self, false, false)
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
end

FragmentTeamConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

FragmentTeamConfirmDialog.SetData = function(self, data, index)
  -- function num : 0_3 , upvalues : _ENV
  if #self._data > 0 then
    LogError("FragmentTeamConfirmDialog", "Team data already exists!")
  end
  self._data = {}
  for i,v in ipairs(data) do
    if v ~= -1 then
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(v)
      ;
      (table.insert)(self._data, role)
    end
  end
  self.index = index
  ;
  (self._frame):ReloadAllCell()
end

FragmentTeamConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

FragmentTeamConfirmDialog.OnConfirmBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cbattlestart")
  if csend then
    csend.battleType = csend.SHATTERED
    csend.id = self.index
    csend.lineupID = 0
    local temp = {}
    if (self._data)[1] then
      temp[1] = ((self._data)[1]):GetRoleId()
    end
    if (self._data)[2] then
      temp[2] = ((self._data)[2]):GetRoleId()
    end
    if (self._data)[3] then
      temp[3] = ((self._data)[3]):GetRoleId()
    end
    csend.lineup = temp
    csend:Send()
  end
  do
    self:Destroy()
  end
end

FragmentTeamConfirmDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_6
  return #self._data
end

FragmentTeamConfirmDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "mainline.fragment.teamrecordcharcell"
end

FragmentTeamConfirmDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._data)[index]
end

return FragmentTeamConfirmDialog

