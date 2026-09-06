local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CItemAccessType = BeanManager.GetTableByName("item.citemaccesstype")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTipsGainBigCell = class("ItemTipsGainBigCell", Dialog)
ItemTipsGainBigCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainBigCell.AssetName = "ItemTipsNewGet1"

function ItemTipsGainBigCell:Ctor(...)
  ItemTipsGainBigCell.super.Ctor(self, ...)
  self._show = true
  self._lastShow = self._show
  self._cellIndexList = {}
end

function ItemTipsGainBigCell:OnCreate()
  self._cellPanel = self:GetChild("Frame")
  self._title = self:GetChild("Title")
  self._showBtn = self:GetChild("Add")
  self._hideBtn = self:GetChild("Reduce")
  self._frame = TableFrame.Create(self._cellPanel, self, true, false, true)
  self._cellPanelWidth, self._cellPanelHeight = self._cellPanel:GetRectSize()
  self._rootWindowWidth, self._rootWindowHeight = self:GetRootWindow():GetRectSize()
  self._anchorY, self._offsetY = self._cellPanel:GetYPosition()
  self._showBtn:Subscribe_PointerClickEvent(self.OnShowGainWays, self)
  self._hideBtn:Subscribe_PointerClickEvent(self.OnShowGainWays, self)
end

function ItemTipsGainBigCell:OnDestroy()
  self._frame:Destroy()
end

function ItemTipsGainBigCell:RefreshCell(data)
  self._title:SetText(TextManager.GetText(CItemAccessType:GetRecorder(data.type).type))
  while self._cellIndexList[#self._cellIndexList] do
    table.remove(self._cellIndexList, #self._cellIndexList)
  end
  local len = #data.ways
  for i = len, 1, -1 do
    table.insert(self._cellIndexList, i)
  end
  self._showBtn:SetActive(not self._show)
  self._hideBtn:SetActive(self._show)
  self:ShowGainWays()
end

function ItemTipsGainBigCell:ShouldLengthChange()
  return true
end

function ItemTipsGainBigCell:NumberOfCell(frame)
  return #self._cellData.ways
end

function ItemTipsGainBigCell:CellAtIndex(frame, index)
  return "bag.itemtipsgainsmallcell"
end

function ItemTipsGainBigCell:DataAtIndex(frame, index)
  return self._cellData.ways[index]
end

function ItemTipsGainBigCell:OnShowGainWays()
  self._show = not self._show
  self._showBtn:SetActive(not self._show)
  self._hideBtn:SetActive(self._show)
  self:ShowGainWays()
end

function ItemTipsGainBigCell:ShowGainWays()
  if self._show then
    self._frame:ReloadAllCell()
    self._frame:MoveToTop()
    local totalLength = self._frame:GetTotalLength()
    self._cellPanel:SetSize(0, self._cellPanelWidth, 0, totalLength)
    self._cellPanel:SetYPosition(self._anchorY, self._offsetY - (totalLength - self._cellPanelHeight))
    self:GetRootWindow():SetSize(0, self._rootWindowWidth, 0, self._rootWindowHeight + totalLength)
    if self._show ~= self._lastShow then
      self._delegate:ChangeFrameHeight()
      self._lastShow = self._show
    end
  elseif self._show ~= self._lastShow then
    self._frame:RemoveCellsAtIndex(self._cellIndexList)
    local totalLength = self._frame:GetTotalLength()
    self._cellPanel:SetSize(0, self._cellPanelWidth, 0, totalLength)
    self._cellPanel:SetYPosition(self._anchorY, self._offsetY - (totalLength - self._cellPanelHeight))
    self:GetRootWindow():SetSize(0, self._rootWindowWidth, 0, self._rootWindowHeight + totalLength)
    self._delegate:ChangeFrameHeight()
    self._lastShow = self._show
  end
end

return ItemTipsGainBigCell
