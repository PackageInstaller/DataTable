local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTipsUniqueEquipAttrPanelCell = class("ItemTipsUniqueEquipAttrPanelCell", Dialog)
ItemTipsUniqueEquipAttrPanelCell.AssetBundleName = "ui/layouts.bag"
ItemTipsUniqueEquipAttrPanelCell.AssetName = "ItemTipsNewEquipAttribute"

function ItemTipsUniqueEquipAttrPanelCell:Ctor(...)
  ItemTipsUniqueEquipAttrPanelCell.super.Ctor(self, ...)
end

function ItemTipsUniqueEquipAttrPanelCell:OnCreate()
  self._cellPanel = self:GetChild("Equiptips")
  self._frame = TableFrame.Create(self._cellPanel, self, true, false, true)
end

function ItemTipsUniqueEquipAttrPanelCell:OnDestroy()
  self._frame:Destroy()
end

function ItemTipsUniqueEquipAttrPanelCell:RefreshCell(data)
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function ItemTipsUniqueEquipAttrPanelCell:NumberOfCell(frame)
  return #self._cellData.value
end

function ItemTipsUniqueEquipAttrPanelCell:CellAtIndex(frame, index)
  return "bag.itemtipsuniqueequipattrcell"
end

function ItemTipsUniqueEquipAttrPanelCell:DataAtIndex(frame, index)
  return self._cellData.value[index]
end

return ItemTipsUniqueEquipAttrPanelCell
