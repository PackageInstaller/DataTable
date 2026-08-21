-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/resource/completelineupdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BottomToTop = 2
local CompleteLineupDialog = class("CompleteLineupDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
CompleteLineupDialog.AssetBundleName = "ui/layouts.mainline"
CompleteLineupDialog.AssetName = "ResourceSelectTeam"
CompleteLineupDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CompleteLineupDialog
  ((CompleteLineupDialog.super).Ctor)(self, ...)
end

CompleteLineupDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, _ENV, TableFrame
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._emptyTxt = self:GetChild("Back/EmptyTxt")
  ;
  (self._emptyTxt):SetText((TextManager.GetText)(701029))
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._width = (self._panel):GetRectSize()
end

CompleteLineupDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._frame then
    (self._frame):Destroy()
  end
end

CompleteLineupDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._data = {}
  if data and #data.completeLineups > 0 then
    (self._emptyTxt):SetActive(false)
  else
    ;
    (self._emptyTxt):SetActive(true)
  end
  for i,lineupInfo in ipairs(data.completeLineups) do
    local temp = {}
    temp.userId = lineupInfo.userId
    temp.userName = lineupInfo.userName
    temp.avatarId = lineupInfo.avatarId
    temp.frameId = lineupInfo.frameId
    temp.userLv = lineupInfo.userLv
    temp.roles = lineupInfo.roles
    ;
    (table.insert)(self._data, temp)
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

CompleteLineupDialog.OnCurPosChange = function(self, frame, proportion)
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

CompleteLineupDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "mainline.resource.completelineupcell"
end

CompleteLineupDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

CompleteLineupDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._data
end

CompleteLineupDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

return CompleteLineupDialog

