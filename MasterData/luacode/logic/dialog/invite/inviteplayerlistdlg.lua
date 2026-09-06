local GridFrame = require("framework.ui.frame.grid.gridframe")
local CInviteeRewards = BeanManager.GetTableByName("activity.cinviteerewards")
local InviteUtil = require("logic.dialog.invite.inviteutil")
local InvitePlayerListDlg = class("InvitePlayerListDlg", Dialog)
InvitePlayerListDlg.AssetBundleName = "ui/layouts.invite"
InvitePlayerListDlg.AssetName = "InvitePlayerFrame"

function InvitePlayerListDlg:Ctor(...)
  InvitePlayerListDlg.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function InvitePlayerListDlg:OnCreate()
  self._closeBtn = self:GetChild("CloseBtn")
  self._framePanel = self:GetChild("Frame")
  self._curNum = self:GetChild("TipsText3/CurNum")
  self._maxNum = self:GetChild("TipsText3/MaxNum")
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(3)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = GridFrame.Create(self._framePanel, self, true, 1)
end

function InvitePlayerListDlg:OnDestroy()
  self._frame:Destroy()
  self._playerList = nil
end

function InvitePlayerListDlg:Update(data)
  self._playerList = data.users
  self._frame:ReloadAllCell()
  local cur, max = #data.users, data.limitNum
  self._curNum:SetText(cur)
  self._maxNum:SetText(max)
end

function InvitePlayerListDlg:NumberOfCell(frame)
  if frame == self._frame then
    return #self._playerList
  end
end

function InvitePlayerListDlg:CellAtIndex(frame, index)
  if frame == self._frame then
    return "invite.inviteplayercell"
  end
end

function InvitePlayerListDlg:DataAtIndex(frame, index)
  if frame == self._frame then
    return self._playerList[index]
  end
end

function InvitePlayerListDlg:OnBackBtnClicked()
  self:Destroy()
end

function InvitePlayerListDlg:OnCurPosChange(frame, proportion)
  local width, height = self._framePanel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetScrollSize(1)
    self._scrollBar:SetScrollValue(proportion)
  end
end

return InvitePlayerListDlg
