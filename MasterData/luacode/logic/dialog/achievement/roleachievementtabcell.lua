local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 4
local RoleAchievementTabCell = class("RoleAchievementTabCell", Dialog)
RoleAchievementTabCell.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementTabCell.AssetName = "AchievementFrame"

function RoleAchievementTabCell:Ctor(...)
  RoleAchievementTabCell.super.Ctor(self, ...)
  self._init = false
  self._filterType = "all"
end

function RoleAchievementTabCell:OnCreate()
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._width, self._height = self._panel:GetRectSize()
end

function RoleAchievementTabCell:OnDestroy()
  self._frame:Destroy()
end

function RoleAchievementTabCell:RefreshTabCell(data)
  if not self._init then
    self._data = data
    self._frame:ReloadAllCell()
    self._frame:MoveToTop()
    self._delegate:SetEmpty(#self._data == 0)
  end
end

function RoleAchievementTabCell:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function RoleAchievementTabCell:NumberOfCell(frame)
  return #self._data
end

function RoleAchievementTabCell:CellAtIndex(frame, index)
  return "achievement.roleachievementdetailcell"
end

function RoleAchievementTabCell:DataAtIndex(frame, index)
  return {
    task = self._data[index]
  }
end

return RoleAchievementTabCell
