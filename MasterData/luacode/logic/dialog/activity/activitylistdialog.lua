local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 2
local ActivityListDialog = class("ActivityListDialog", Dialog)
ActivityListDialog.AssetBundleName = "ui/layouts.activityhud"
ActivityListDialog.AssetName = "ActivityList"

function ActivityListDialog:Ctor(...)
  ActivityListDialog.super.Ctor(self, ...)
  self._groupName = "Default"
end

function ActivityListDialog:OnCreate()
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._width, self._height = self._panel:GetRectSize()
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.OnRefreshActivities, Common.n_RefreshActivities, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshActivities, Common.n_LocalTipsStateChanged, nil)
end

function ActivityListDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
end

function ActivityListDialog:OnRefreshActivities()
  local lastPos = self._frame:GetCurrentPosition()
  self._list = NekoData.BehaviorManager.BM_Activity:GetEntrances()
  self._frame:ReloadAllCell()
  if lastPos then
    self._frame:MoveToAssignedPos(lastPos)
  end
end

function ActivityListDialog:Init()
  self._list = NekoData.BehaviorManager.BM_Activity:GetEntrances()
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function ActivityListDialog:NumberOfCell(frame)
  return #self._list
end

function ActivityListDialog:CellAtIndex(frame)
  return "activity.activitylistcell"
end

function ActivityListDialog:DataAtIndex(frame, index)
  return self._list[index]
end

function ActivityListDialog:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function ActivityListDialog:OnBackBtnClicked()
  self:Destroy()
end

return ActivityListDialog
