local TableFrame = require("framework.ui.frame.table.tableframe")
local PassiveSkillCell = class("PassiveSkillCell", Dialog)
PassiveSkillCell.AssetBundleName = "ui/layouts.basecharacterinfo"
PassiveSkillCell.AssetName = "BaseCharacterInfoSkillNewFrame1"

function PassiveSkillCell:Ctor(...)
  PassiveSkillCell.super.Ctor(self, ...)
  self._data = nil
  self._roleKey = nil
end

function PassiveSkillCell:OnCreate()
  self._frame = TableFrame.Create(self._rootWindow, self, true, false, true)
  LuaNotificationCenter.AddObserver(self, self.OnRoleBreakUp, Common.n_RoleInfoChange, nil)
end

function PassiveSkillCell:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function PassiveSkillCell:RefreshCell(data)
  self._roleKey = data:GetRoleId()
  self._data = {}
  for i, v in ipairs(data:GetPassiveSkillList()) do
    local temp = {}
    temp.id = v.id
    temp.unlock = v.lock == 1
    table.insert(self._data, temp)
  end
  for i, v in ipairs(self._data) do
    v.count = #self._data
    v.index = i
  end
  self._frame:ReloadAllCell()
end

function PassiveSkillCell:NumberOfCell(frame)
  return #self._data
end

function PassiveSkillCell:CellAtIndex(frame)
  return "character.passiveskillcellcell"
end

function PassiveSkillCell:DataAtIndex(frame, index)
  return self._data[index]
end

function PassiveSkillCell:OnRoleBreakUp(notification)
  if notification.userInfo.name == "sroleupdatebreaklv" and notification.userInfo.key == self._roleKey then
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(notification.userInfo.key)
    self:RefreshCell(role)
  end
end

return PassiveSkillCell
