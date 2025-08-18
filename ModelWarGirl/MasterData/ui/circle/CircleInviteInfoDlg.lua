-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleInviteInfoDlg.lua

local CircleInviteMsgCell = require("UI/Circle/CircleInviteMsgCell")
local strClassName = "CircleInviteInfoDlg"
local CircleInviteInfoDlg = Class(strClassName, UIControls.Window)

function CircleInviteInfoDlg:ctor()
	self:initUI()
end

function CircleInviteInfoDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.cells = {}
	self.scrollInviteMsg = UIControls.ScrollViewLoopV(self, "BgPanel/CircleInviteMessageList")

	self.scrollInviteMsg:addEventCellChanged(self.onInviteMsgChanged)

	self.panelTextNone = UIControls.Panel(self, "BgPanel/TextNone")
end

function CircleInviteInfoDlg:onInviteMsgChanged(sender, targetCell, newIdx)
	targetCell = targetCell or CircleInviteMsgCell(sender, "System/Circle/CircleInviteMessageCell", newIdx)

	if not self.inviteMsgDataList or #self.inviteMsgDataList == 0 then
		return
	end

	if self.inviteMsgDataList[newIdx] ~= nil then
		targetCell:setInviteMsgData(self.inviteMsgDataList[newIdx], newIdx)
	end

	self.cells[newIdx] = targetCell
end

function CircleInviteInfoDlg:setInviteMsgData(inviteMsgDataList)
	self.inviteMsgDataList = inviteMsgDataList

	self.scrollInviteMsg:setTotalCount(#self.inviteMsgDataList)
	self.panelTextNone:setVisible(#self.inviteMsgDataList == 0)
end

function CircleInviteInfoDlg:onBtnCloseClick()
	self:setVisible(false)
end

return CircleInviteInfoDlg
