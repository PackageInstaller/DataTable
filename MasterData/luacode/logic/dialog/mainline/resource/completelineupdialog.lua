local BottomToTop = 2
local CompleteLineupDialog = class("CompleteLineupDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
CompleteLineupDialog.AssetBundleName = "ui/layouts.mainline"
CompleteLineupDialog.AssetName = "ResourceSelectTeam"

function CompleteLineupDialog:Ctor(...)
  CompleteLineupDialog.super.Ctor(self, ...)
end

function CompleteLineupDialog:OnCreate()
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._emptyTxt = self:GetChild("Back/EmptyTxt")
  self._emptyTxt:SetText(TextManager.GetText(701029))
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._width, self._height = self._panel:GetRectSize()
end

function CompleteLineupDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function CompleteLineupDialog:Init(data)
  self._data = {}
  if data and #data.completeLineups > 0 then
    self._emptyTxt:SetActive(false)
  else
    self._emptyTxt:SetActive(true)
  end
  for i, lineupInfo in ipairs(data.completeLineups) do
    local temp = {}
    temp.userId = lineupInfo.userId
    temp.userName = lineupInfo.userName
    temp.avatarId = lineupInfo.avatarId
    temp.frameId = lineupInfo.frameId
    temp.userLv = lineupInfo.userLv
    temp.roles = lineupInfo.roles
    table.insert(self._data, temp)
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function CompleteLineupDialog:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function CompleteLineupDialog:CellAtIndex(frame, index)
  return "mainline.resource.completelineupcell"
end

function CompleteLineupDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function CompleteLineupDialog:NumberOfCell(frame)
  return #self._data
end

function CompleteLineupDialog:OnBackBtnClicked()
  self:Destroy()
end

return CompleteLineupDialog
