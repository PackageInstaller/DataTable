local CItemAccessType = BeanManager.GetTableByName("item.citemaccesstype")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTipsGainTypeSpecialCell = class("ItemTipsGainTypeSpecialCell", Dialog)
ItemTipsGainTypeSpecialCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainTypeSpecialCell.AssetName = "ItemTipsNewGetSpecial"

function ItemTipsGainTypeSpecialCell:Ctor(...)
  ItemTipsGainTypeSpecialCell.super.Ctor(self, ...)
end

function ItemTipsGainTypeSpecialCell:OnCreate()
  self._title = self:GetChild("Title")
  self._cellPanel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._cellPanel, self, true, false, true)
  self._cellPanelX, self._cellPanelOX, self._cellPanelY, self._cellPanelOY = self._cellPanel:GetPosition()
  self._cellPanelRectX, self._cellPanelRectY = self._cellPanel:GetRectSize()
  self._rwX, self._rwOX, self._rwY, self._rwOY = self:GetRootWindow():GetPosition()
  self._rwRectX, self._rwRectY = self:GetRootWindow():GetRectSize()
  self._frameRectX, self._frameRectY = self._cellPanel:GetRectSize()
end

function ItemTipsGainTypeSpecialCell:OnDestroy()
  self._frame:Destroy()
end

function ItemTipsGainTypeSpecialCell:RefreshCell(data)
  self._title:SetText(TextManager.GetText(CItemAccessType:GetRecorder(data.type).type))
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  local delta = self._frame:GetTotalLength() - self._frameRectY
  if 0 < delta then
    self._rootWindow:SetHeight(0, self._rwRectY + delta)
    self._cellPanel:SetHeight(0, self._cellPanelRectY + delta)
    self._cellPanel:SetPosition(self._cellPanelX, self._cellPanelOX, self._cellPanelY, self._cellPanelOY - delta)
  end
end

function ItemTipsGainTypeSpecialCell:ShouldLengthChange()
  return true
end

function ItemTipsGainTypeSpecialCell:NumberOfCell(frame)
  return #self._cellData.ways
end

function ItemTipsGainTypeSpecialCell:CellAtIndex(frame, index)
  return "bag.itemtipsgainspecialtextcell"
end

function ItemTipsGainTypeSpecialCell:DataAtIndex(frame, index)
  return self._cellData.ways[index]
end

return ItemTipsGainTypeSpecialCell
