-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemtipsgainbigcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CItemAccessType = (BeanManager.GetTableByName)("item.citemaccesstype")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTipsGainBigCell = class("ItemTipsGainBigCell", Dialog)
ItemTipsGainBigCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainBigCell.AssetName = "ItemTipsNewGet1"
ItemTipsGainBigCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemTipsGainBigCell
  ((ItemTipsGainBigCell.super).Ctor)(self, ...)
  self._show = true
  self._lastShow = self._show
  self._cellIndexList = {}
end

ItemTipsGainBigCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._cellPanel = self:GetChild("Frame")
  self._title = self:GetChild("Title")
  self._showBtn = self:GetChild("Add")
  self._hideBtn = self:GetChild("Reduce")
  self._frame = (TableFrame.Create)(self._cellPanel, self, true, false, true)
  self._cellPanelWidth = (self._cellPanel):GetRectSize()
  self._rootWindowWidth = (self:GetRootWindow()):GetRectSize()
  self._anchorY = (self._cellPanel):GetYPosition()
  ;
  (self._showBtn):Subscribe_PointerClickEvent(self.OnShowGainWays, self)
  ;
  (self._hideBtn):Subscribe_PointerClickEvent(self.OnShowGainWays, self)
end

ItemTipsGainBigCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

ItemTipsGainBigCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CItemAccessType
  (self._title):SetText((TextManager.GetText)((CItemAccessType:GetRecorder(data.type)).type))
  while (self._cellIndexList)[#self._cellIndexList] do
    (table.remove)(self._cellIndexList, #self._cellIndexList)
  end
  local len = #data.ways
  for i = len, 1, -1 do
    (table.insert)(self._cellIndexList, i)
  end
  ;
  (self._showBtn):SetActive(not self._show)
  ;
  (self._hideBtn):SetActive(self._show)
  self:ShowGainWays()
end

ItemTipsGainBigCell.ShouldLengthChange = function(self)
  -- function num : 0_4
  return true
end

ItemTipsGainBigCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #(self._cellData).ways
end

ItemTipsGainBigCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "bag.itemtipsgainsmallcell"
end

ItemTipsGainBigCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return ((self._cellData).ways)[index]
end

ItemTipsGainBigCell.OnShowGainWays = function(self)
  -- function num : 0_8
  self._show = not self._show
  ;
  (self._showBtn):SetActive(not self._show)
  ;
  (self._hideBtn):SetActive(self._show)
  self:ShowGainWays()
end

ItemTipsGainBigCell.ShowGainWays = function(self)
  -- function num : 0_9
  if self._show then
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
    local totalLength = (self._frame):GetTotalLength()
    ;
    (self._cellPanel):SetSize(0, self._cellPanelWidth, 0, totalLength)
    ;
    (self._cellPanel):SetYPosition(self._anchorY, self._offsetY - (totalLength - self._cellPanelHeight))
    ;
    (self:GetRootWindow()):SetSize(0, self._rootWindowWidth, 0, self._rootWindowHeight + totalLength)
    if self._show ~= self._lastShow then
      (self._delegate):ChangeFrameHeight()
      self._lastShow = self._show
    end
  else
    do
      if self._show ~= self._lastShow then
        (self._frame):RemoveCellsAtIndex(self._cellIndexList)
        local totalLength = (self._frame):GetTotalLength()
        ;
        (self._cellPanel):SetSize(0, self._cellPanelWidth, 0, totalLength)
        ;
        (self._cellPanel):SetYPosition(self._anchorY, self._offsetY - (totalLength - self._cellPanelHeight))
        ;
        (self:GetRootWindow()):SetSize(0, self._rootWindowWidth, 0, self._rootWindowHeight + totalLength)
        ;
        (self._delegate):ChangeFrameHeight()
        self._lastShow = self._show
      end
    end
  end
end

return ItemTipsGainBigCell

