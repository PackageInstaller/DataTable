-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/activitylistdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 2
local ActivityListDialog = class("ActivityListDialog", Dialog)
ActivityListDialog.AssetBundleName = "ui/layouts.activityhud"
ActivityListDialog.AssetName = "ActivityList"
ActivityListDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ActivityListDialog
  ((ActivityListDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
end

ActivityListDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, _ENV
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._width = (self._panel):GetRectSize()
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshActivities, Common.n_RefreshActivities, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshActivities, Common.n_LocalTipsStateChanged, nil)
end

ActivityListDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
end

ActivityListDialog.OnRefreshActivities = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local lastPos = (self._frame):GetCurrentPosition()
  self._list = ((NekoData.BehaviorManager).BM_Activity):GetEntrances()
  ;
  (self._frame):ReloadAllCell()
  if lastPos then
    (self._frame):MoveToAssignedPos(lastPos)
  end
end

ActivityListDialog.Init = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._list = ((NekoData.BehaviorManager).BM_Activity):GetEntrances()
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

ActivityListDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._list
end

ActivityListDialog.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "activity.activitylistcell"
end

ActivityListDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._list)[index]
end

ActivityListDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
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

ActivityListDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

return ActivityListDialog

