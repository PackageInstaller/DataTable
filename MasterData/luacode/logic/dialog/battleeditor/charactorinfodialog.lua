local TableFrame = require("framework.ui.frame.table.tableframe")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CharactorInfoDialog = class("CharactorInfoDialog", Dialog)
CharactorInfoDialog.AssetBundleName = "ui/layouts.battleeditor"
CharactorInfoDialog.AssetName = "CharactorInfo"

function CharactorInfoDialog:Ctor(...)
  CharactorInfoDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function CharactorInfoDialog:OnCreate(root)
  self._charatorInfoFrame = self:GetChild("CharatorInfoFrame")
  self._exit = self:GetChild("BackBtn")
  self._exit:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = TableFrame.Create(self._charatorInfoFrame, self, false)
  self._frame:ReloadAllCell()
end

function CharactorInfoDialog:OnDestroy()
  self._frame:Destroy()
end

function CharactorInfoDialog:NumberOfCell(frame)
  return #RoleConfigTable:GetAllIds()
end

function CharactorInfoDialog:CellAtIndex(frame)
  return "battleeditor.charactorinfocell"
end

function CharactorInfoDialog:DataAtIndex(frame, index)
  local ids = RoleConfigTable:GetAllIds()
  return RoleConfigTable:GetRecorder(ids[index])
end

function CharactorInfoDialog:ShouldLengthChange(frame)
  return false
end

function CharactorInfoDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("battleeditor.charactorinfodialog")
end

return CharactorInfoDialog
