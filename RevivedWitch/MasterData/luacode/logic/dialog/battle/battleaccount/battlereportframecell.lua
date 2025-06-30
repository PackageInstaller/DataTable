-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/battlereportframecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local BattleReportFrameCell = class("BattleReportFrameCell", Dialog)
BattleReportFrameCell.AssetBundleName = "ui/layouts.battlewin"
BattleReportFrameCell.AssetName = "BattleReportFrame"
local CampType = {Left = 1, Right = 2}
local colNum = 3
BattleReportFrameCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleReportFrameCell
  ((BattleReportFrameCell.super).Ctor)(self, ...)
end

BattleReportFrameCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, colNum
  self._frame = (GridFrame.Create)(self:GetRootWindow(), self, true, colNum, false)
end

BattleReportFrameCell.OnDestroy = function(self)
  -- function num : 0_2
  if self._frame then
    (self._frame):Destroy()
    self._frame = nil
  end
end

BattleReportFrameCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._data = data
  self._canCheckRoleDetail = (self._delegate)._canCheckRoleDetail
  ;
  (self._frame):ReloadAllCell()
end

BattleReportFrameCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

BattleReportFrameCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if ((self._data)[index]).isPartner then
    return "battle.battleaccount.battlereportsupportcell"
  else
    if ((self._data)[index]).isRole then
      return "battle.battleaccount.battlereportcharcell"
    else
      return "battle.battleaccount.battlereportbosscell"
    end
  end
end

BattleReportFrameCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

return BattleReportFrameCell

