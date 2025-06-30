-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/roleachievementtabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 4
local RoleAchievementTabCell = class("RoleAchievementTabCell", Dialog)
RoleAchievementTabCell.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementTabCell.AssetName = "AchievementFrame"
RoleAchievementTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleAchievementTabCell
  ((RoleAchievementTabCell.super).Ctor)(self, ...)
  self._init = false
  self._filterType = "all"
end

RoleAchievementTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._width = (self._panel):GetRectSize()
end

RoleAchievementTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

RoleAchievementTabCell.RefreshTabCell = function(self, data)
  -- function num : 0_3
  if not self._init then
    self._data = data
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
    ;
    (self._delegate):SetEmpty(#self._data == 0)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

RoleAchievementTabCell.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_4
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(self._height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

RoleAchievementTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

RoleAchievementTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "achievement.roleachievementdetailcell"
end

RoleAchievementTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return {task = (self._data)[index]}
end

return RoleAchievementTabCell

