-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/uniqueequip/uniqueequipskilldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local UniqueEquipSkillDialog = class("UniqueEquipSkillDialog", Dialog)
UniqueEquipSkillDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
UniqueEquipSkillDialog.AssetName = "CharEquipSkill"
UniqueEquipSkillDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UniqueEquipSkillDialog
  ((UniqueEquipSkillDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

UniqueEquipSkillDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

UniqueEquipSkillDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

UniqueEquipSkillDialog.SetData = function(self, uniqueEquipItem)
  -- function num : 0_3
  self._uniqueEquipItem = uniqueEquipItem
  self._roleId = uniqueEquipItem:GetRoleId()
  self._list = uniqueEquipItem:GetSkillList()
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

UniqueEquipSkillDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._list
end

UniqueEquipSkillDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "uniqueequip.uniqueequipskillcell"
end

UniqueEquipSkillDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._list)[index]
end

UniqueEquipSkillDialog.ShouldLengthChange = function(self)
  -- function num : 0_7
  return true
end

UniqueEquipSkillDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

return UniqueEquipSkillDialog

