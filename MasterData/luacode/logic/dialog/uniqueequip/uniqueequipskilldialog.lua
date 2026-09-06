local TableFrame = require("framework.ui.frame.table.tableframe")
local UniqueEquipSkillDialog = class("UniqueEquipSkillDialog", Dialog)
UniqueEquipSkillDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
UniqueEquipSkillDialog.AssetName = "CharEquipSkill"

function UniqueEquipSkillDialog:Ctor(...)
  UniqueEquipSkillDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function UniqueEquipSkillDialog:OnCreate()
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function UniqueEquipSkillDialog:OnDestroy()
  self._frame:Destroy()
end

function UniqueEquipSkillDialog:SetData(uniqueEquipItem)
  self._uniqueEquipItem = uniqueEquipItem
  self._roleId = uniqueEquipItem:GetRoleId()
  self._list = uniqueEquipItem:GetSkillList()
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function UniqueEquipSkillDialog:NumberOfCell(frame)
  return #self._list
end

function UniqueEquipSkillDialog:CellAtIndex(frame, index)
  return "uniqueequip.uniqueequipskillcell"
end

function UniqueEquipSkillDialog:DataAtIndex(frame, index)
  return self._list[index]
end

function UniqueEquipSkillDialog:ShouldLengthChange()
  return true
end

function UniqueEquipSkillDialog:OnBackBtnClicked()
  self:Destroy()
end

return UniqueEquipSkillDialog
