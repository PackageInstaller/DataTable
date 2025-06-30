-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemtipsgainwayscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local SingleJumpMap = {[(DataCommon.GainTypeEnum).Tower] = true, [(DataCommon.GainTypeEnum).Fragment] = true, [(DataCommon.GainTypeEnum).ResourceMain] = true, [(DataCommon.GainTypeEnum).UndecidedRoad] = true, [(DataCommon.GainTypeEnum).WeekBoss] = true}
local ItemTipsGainWaysCell = class("ItemTipsGainWaysCell", Dialog)
ItemTipsGainWaysCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainWaysCell.AssetName = "ItemTipsNewGet1Frame"
ItemTipsGainWaysCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemTipsGainWaysCell
  ((ItemTipsGainWaysCell.super).Ctor)(self, ...)
end

ItemTipsGainWaysCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._cellPanel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._cellPanel, self, true, false, true)
  self._cellPanelWidth = (self._cellPanel):GetRectSize()
  self._rootWindowWidth = (self:GetRootWindow()):GetRectSize()
  self._anchorY = (self._cellPanel):GetYPosition()
end

ItemTipsGainWaysCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

ItemTipsGainWaysCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._frame):ReloadAllCell()
  local totalLength = (self._frame):GetTotalLength()
  ;
  (self._cellPanel):SetSize(0, self._cellPanelWidth, 0, totalLength)
  ;
  (self._cellPanel):SetYPosition(self._anchorY, self._offsetY - totalLength)
  ;
  (self:GetRootWindow()):SetSize(0, self._rootWindowWidth, 0, self._rootWindowHeight + totalLength)
  ;
  (self._frame):MoveToTop()
end

ItemTipsGainWaysCell.NumberOfCell = function(self, frame)
  -- function num : 0_4 , upvalues : SingleJumpMap
  if SingleJumpMap[(self._cellData).type] then
    return 1
  else
    return #(self._cellData).ways
  end
end

ItemTipsGainWaysCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "bag.itemtipsgainsmallcell"
end

ItemTipsGainWaysCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return ((self._cellData).ways)[index]
end

return ItemTipsGainWaysCell

