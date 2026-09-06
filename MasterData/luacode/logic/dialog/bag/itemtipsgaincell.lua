local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTipsGainCell = class("ItemTipsGainCell", Dialog)
ItemTipsGainCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainCell.AssetName = "ItemTipsNewGet"

function ItemTipsGainCell:Ctor(...)
  ItemTipsGainCell.super.Ctor(self, ...)
  self._dataList = {}
  self._dataMap = {}
  self._init = true
end

function ItemTipsGainCell:OnCreate()
  self._cellPanel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._cellPanel, self, true, false, true)
  self._cellPanelWidth, self._cellPanelHeight = self._cellPanel:GetRectSize()
  self._rootWindwoWidth, self._rootWindowHeight = self:GetRootWindow():GetRectSize()
  self._anchorY, self._offsetY = self:GetRootWindow():GetHeight()
  self._size_x, self._size_offset_x, self._size_y, self._size_offset_y = self:GetRootWindow():GetSize()
  self._posAnchorY, self._posOffsetY = self:GetRootWindow():GetYPosition()
end

function ItemTipsGainCell:OnDestroy()
  self._frame:Destroy()
end

function ItemTipsGainCell:RefreshCell(data)
  if self._init then
    self._init = false
    for i, v in ipairs(data.value) do
      table.insert(self._dataList, {
        data = v,
        isType = v.type
      })
      self._dataMap[v.type] = false
    end
    if #self._dataList == 1 and self._dataList[1].isType ~= DataCommon.GainTypeEnum.Special and self._dataList[1].isType ~= DataCommon.GainTypeEnum.Lover then
      self._dataMap[self._dataList[1].isType] = true
      table.insert(self._dataList, {
        data = self._dataList[1].data,
        isWays = true
      })
    end
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  local totalLength = self._frame:GetTotalLength()
  self:GetRootWindow():SetHeight(self._anchorY, self._offsetY + totalLength)
end

function ItemTipsGainCell:ShowGainWays(type)
  self._dataMap[type] = not self._dataMap[type]
  if self._dataMap[type] then
    local index
    for i, v in ipairs(self._dataList) do
      if v.data.type == type then
        index = i
        break
      end
    end
    table.insert(self._dataList, index + 1, {
      data = self._dataList[index].data,
      isWays = true
    })
    self._frame:InsertCellsAtIndex({
      index + 1
    })
  else
    local index
    for i, v in ipairs(self._dataList) do
      if v.data.type == type and v.isWays then
        index = i
        break
      end
    end
    table.remove(self._dataList, index)
    self._frame:RemoveCellsAtIndex({index})
  end
  self._frame:FireEvent("RefreshOperateBtn")
  local totalLength = self._frame:GetTotalLength()
  self:GetRootWindow():SetHeight(self._anchorY, self._offsetY + totalLength)
  self._delegate:ReloadGainCell(self._cellData.tag)
end

function ItemTipsGainCell:ShouldLengthChange()
  return true
end

function ItemTipsGainCell:NumberOfCell(frame)
  return #self._dataList
end

function ItemTipsGainCell:CellAtIndex(frame, index)
  if self._dataList[index].isType then
    if self._dataList[index].isType == DataCommon.GainTypeEnum.Special or self._dataList[index].isType == DataCommon.GainTypeEnum.Lover then
      return "bag.itemtipsgaintypespecialcell"
    else
      return "bag.itemtipsgaintypecell"
    end
  else
    return "bag.itemtipsgainwayscell"
  end
end

function ItemTipsGainCell:DataAtIndex(frame, index)
  return self._dataList[index].data
end

return ItemTipsGainCell
