-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemtipsgaintypespecialcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CItemAccessType = (BeanManager.GetTableByName)("item.citemaccesstype")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTipsGainTypeSpecialCell = class("ItemTipsGainTypeSpecialCell", Dialog)
ItemTipsGainTypeSpecialCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainTypeSpecialCell.AssetName = "ItemTipsNewGetSpecial"
ItemTipsGainTypeSpecialCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemTipsGainTypeSpecialCell
  ((ItemTipsGainTypeSpecialCell.super).Ctor)(self, ...)
end

ItemTipsGainTypeSpecialCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._title = self:GetChild("Title")
  self._cellPanel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._cellPanel, self, true, false, true)
  self._cellPanelX = (self._cellPanel):GetPosition()
  self._cellPanelRectX = (self._cellPanel):GetRectSize()
  self._rwX = (self:GetRootWindow()):GetPosition()
  self._rwRectX = (self:GetRootWindow()):GetRectSize()
  self._frameRectX = (self._cellPanel):GetRectSize()
end

ItemTipsGainTypeSpecialCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

ItemTipsGainTypeSpecialCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CItemAccessType
  (self._title):SetText((TextManager.GetText)((CItemAccessType:GetRecorder(data.type)).type))
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
  local delta = (self._frame):GetTotalLength() - self._frameRectY
  if delta > 0 then
    (self._rootWindow):SetHeight(0, self._rwRectY + delta)
    ;
    (self._cellPanel):SetHeight(0, self._cellPanelRectY + delta)
    ;
    (self._cellPanel):SetPosition(self._cellPanelX, self._cellPanelOX, self._cellPanelY, self._cellPanelOY - delta)
  end
end

ItemTipsGainTypeSpecialCell.ShouldLengthChange = function(self)
  -- function num : 0_4
  return true
end

ItemTipsGainTypeSpecialCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #(self._cellData).ways
end

ItemTipsGainTypeSpecialCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "bag.itemtipsgainspecialtextcell"
end

ItemTipsGainTypeSpecialCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return ((self._cellData).ways)[index]
end

return ItemTipsGainTypeSpecialCell

