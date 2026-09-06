local TableFrame = require("framework.ui.frame.table.tableframe")
local CEquipBox = BeanManager.GetTableByName("recharge.cequipbox")
local TowerLegendDetailDialog = class("TowerLegendDetailDialog", Dialog)
TowerLegendDetailDialog.AssetBundleName = "ui/layouts.baseshop"
TowerLegendDetailDialog.AssetName = "TowerLegendDetail"

function TowerLegendDetailDialog:Ctor(...)
  TowerLegendDetailDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

function TowerLegendDetailDialog:OnCreate()
  self._panel = self:GetChild("Announcement/Frame")
  self._backBtn = self:GetChild("Announcement/CloseBtn")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function TowerLegendDetailDialog:OnDestroy()
  self._frame:Destroy()
end

function TowerLegendDetailDialog:SetData(boxId)
  local recorder = CEquipBox:GetRecorder(boxId)
  self._data = recorder.EquipShowID
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function TowerLegendDetailDialog:OnBackBtnClicked(args)
  self:Destroy()
end

function TowerLegendDetailDialog:NumberOfCell(frame)
  return #self._data
end

function TowerLegendDetailDialog:CellAtIndex(frame, index)
  return "shop.towerlegenddetailcell"
end

function TowerLegendDetailDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function TowerLegendDetailDialog:ShouldLengthChange()
  return true
end

return TowerLegendDetailDialog
