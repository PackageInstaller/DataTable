-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/invite/inviteplayerlistdlg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CInviteeRewards = (BeanManager.GetTableByName)("activity.cinviteerewards")
local InviteUtil = require("logic.dialog.invite.inviteutil")
local InvitePlayerListDlg = class("InvitePlayerListDlg", Dialog)
InvitePlayerListDlg.AssetBundleName = "ui/layouts.invite"
InvitePlayerListDlg.AssetName = "InvitePlayerFrame"
InvitePlayerListDlg.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : InvitePlayerListDlg
  ((InvitePlayerListDlg.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

InvitePlayerListDlg.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._closeBtn = self:GetChild("CloseBtn")
  self._framePanel = self:GetChild("Frame")
  self._curNum = self:GetChild("TipsText3/CurNum")
  self._maxNum = self:GetChild("TipsText3/MaxNum")
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(3)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = (GridFrame.Create)(self._framePanel, self, true, 1)
end

InvitePlayerListDlg.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
  self._playerList = nil
end

InvitePlayerListDlg.Update = function(self, data)
  -- function num : 0_3
  self._playerList = data.users
  ;
  (self._frame):ReloadAllCell()
  local cur, max = #data.users, data.limitNum
  ;
  (self._curNum):SetText(cur)
  ;
  (self._maxNum):SetText(max)
end

InvitePlayerListDlg.NumberOfCell = function(self, frame)
  -- function num : 0_4
  if frame == self._frame then
    return #self._playerList
  end
end

InvitePlayerListDlg.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if frame == self._frame then
    return "invite.inviteplayercell"
  end
end

InvitePlayerListDlg.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._frame then
    return (self._playerList)[index]
  end
end

InvitePlayerListDlg.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

InvitePlayerListDlg.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
  local width, height = (self._framePanel):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetScrollSize(1)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  end
end

return InvitePlayerListDlg

