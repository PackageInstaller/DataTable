-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/passiveskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local PassiveSkillCell = class("PassiveSkillCell", Dialog)
PassiveSkillCell.AssetBundleName = "ui/layouts.basecharacterinfo"
PassiveSkillCell.AssetName = "BaseCharacterInfoSkillNewFrame1"
PassiveSkillCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PassiveSkillCell
  ((PassiveSkillCell.super).Ctor)(self, ...)
  self._data = nil
  self._roleKey = nil
end

PassiveSkillCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._frame = (TableFrame.Create)(self._rootWindow, self, true, false, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleBreakUp, Common.n_RoleInfoChange, nil)
end

PassiveSkillCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

PassiveSkillCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._roleKey = data:GetRoleId()
  self._data = {}
  for i,v in ipairs(data:GetPassiveSkillList()) do
    local temp = {}
    temp.id = v.id
    temp.unlock = v.lock == 1
    ;
    (table.insert)(self._data, temp)
  end
  for i,v in ipairs(self._data) do
    v.count = #self._data
    v.index = i
  end
  ;
  (self._frame):ReloadAllCell()
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

PassiveSkillCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

PassiveSkillCell.CellAtIndex = function(self, frame)
  -- function num : 0_5
  return "character.passiveskillcellcell"
end

PassiveSkillCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

PassiveSkillCell.OnRoleBreakUp = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  if (notification.userInfo).name == "sroleupdatebreaklv" and (notification.userInfo).key == self._roleKey then
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole((notification.userInfo).key)
    self:RefreshCell(role)
  end
end

return PassiveSkillCell

