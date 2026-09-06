local TableFrame = require("framework.ui.frame.table.tableframe")
local SingleJumpMap = {
  [DataCommon.GainTypeEnum.Tower] = true,
  [DataCommon.GainTypeEnum.Fragment] = true,
  [DataCommon.GainTypeEnum.ResourceMain] = true,
  [DataCommon.GainTypeEnum.UndecidedRoad] = true,
  [DataCommon.GainTypeEnum.WeekBoss] = true
}
local ItemTipsGainWaysCell = class("ItemTipsGainWaysCell", Dialog)
ItemTipsGainWaysCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainWaysCell.AssetName = "ItemTipsNewGet1Frame"

function ItemTipsGainWaysCell:Ctor(...)
  ItemTipsGainWaysCell.super.Ctor(self, ...)
end

function ItemTipsGainWaysCell:OnCreate()
  self._cellPanel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._cellPanel, self, true, false, true)
  self._cellPanelWidth, self._cellPanelHeight = self._cellPanel:GetRectSize()
  self._rootWindowWidth, self._rootWindowHeight = self:GetRootWindow():GetRectSize()
  self._anchorY, self._offsetY = self._cellPanel:GetYPosition()
end

function ItemTipsGainWaysCell:OnDestroy()
  self._frame:Destroy()
end

function ItemTipsGainWaysCell:RefreshCell(data)
  self._frame:ReloadAllCell()
  local totalLength = self._frame:GetTotalLength()
  self._cellPanel:SetSize(0, self._cellPanelWidth, 0, totalLength)
  self._cellPanel:SetYPosition(self._anchorY, self._offsetY - totalLength)
  self:GetRootWindow():SetSize(0, self._rootWindowWidth, 0, self._rootWindowHeight + totalLength)
  self._frame:MoveToTop()
end

function ItemTipsGainWaysCell:NumberOfCell(frame)
  if SingleJumpMap[self._cellData.type] then
    return 1
  else
    return #self._cellData.ways
  end
end

function ItemTipsGainWaysCell:CellAtIndex(frame, index)
  return "bag.itemtipsgainsmallcell"
end

function ItemTipsGainWaysCell:DataAtIndex(frame, index)
  return self._cellData.ways[index]
end

return ItemTipsGainWaysCell
