-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleInviteMsgCell.lua

local strClassName = "CircleInviteMsgCell"
local CircleInviteMsgCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function CircleInviteMsgCell:ctor()
	self:initUI()
end

function CircleInviteMsgCell:initUI()
	self.txtName = UIControls.Label(self, "TextName")
	self.txtLevel = UIControls.Label(self, "TextLevelPanel/TextLevel")
	self.txtActive = UIControls.Label(self, "CircleActivePanel/Text")
	self.btnRefuse = UIControls.Button(self, "BtnRefuse")

	self.btnRefuse:addEventClick(self.onBtnRefuseClick)

	self.btnAgree = UIControls.Button(self, "BtnAgree")

	self.btnAgree:addEventClick(self.onBtnAgreeClick)
end

function CircleInviteMsgCell:onBtnRefuseClick()
	if self.circle then
		RPC.clanFuncRefuseInvite(self.circle.gid)
		CurAvatar:tryCloseNoticeChild(self.circle.gid)
	end
end

function CircleInviteMsgCell:onBtnAgreeClick()
	if self.circle then
		RPC.clanJoin(self.circle.gid, Const.CIRCLE_JOIN_TYPE_INVITE)
		CurAvatar:tryCloseNoticeChild(self.circle.gid)
	end
end

function CircleInviteMsgCell:setInviteMsgData(inviteMsgData)
	self.inviteMsgData = inviteMsgData
	self.circle = self.inviteMsgData.circle

	self.txtName:setText(self.circle.name)

	if Const.REVIEW_VERSION then
		self.txtLevel:setText(utils.format(Lang.get(111360), self.circle.level))
	else
		self.txtLevel:setText(utils.format("LV.%1s", self.circle.level))
	end

	self.txtActive:setText(self.circle.weekExp)

	if not self.gridCircle then
		self.gridCircle = UIControls.GridCircleCommonChild(self, "CircleHeadPanel", "System/Common/Grid/GridCircleCommon", 0, 0, true)
	end

	self.gridCircle:setSelectCallback(Slot(self._openShowCircle, self))
	self.gridCircle:setCircle(self.circle)
end

function CircleInviteMsgCell:_openShowCircle()
	local circle = CurAvatar:tryGetCircleDetailInfo(self.circle.gid)

	if circle or self.circle.gid == CurAvatar.circleRoleData.clangid then
		local showCircleDlg = UIManager.getUI("showCircleDlg", true)

		if circle then
			showCircleDlg:setCircle(circle)
			showCircleDlg:convertToInviteMode()
		end
	end
end

return CircleInviteMsgCell
