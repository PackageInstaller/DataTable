-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\ShowCircleDlg.lua

local strClassName = "ShowCircleDlg"
local ShowCircleDlg = Class(strClassName, UIControls.Window)

function ShowCircleDlg:ctor()
	self:initUI()
end

function ShowCircleDlg:initUI()
	self.txtActiveNum = UIControls.Label(self, "BgPanel/ActivePanel/TextNum")
	self.txtName = UIControls.Label(self, "BgPanel/TextName")
	self.txtMemberCount = UIControls.Label(self, "BgPanel/NumPanel/TextNum")
	self.txtId = UIControls.Label(self, "BgPanel/IDPanel/TextID")
	self.txtApplyPassContent = UIControls.Label(self, "BgPanel/TextContent")
	self.txtTitleContent = UIControls.Label(self, "BgPanel/ContentPanel/Text")
	self.txtLevel = UIControls.Label(self, "BgPanel/LVPanel/TextLV")
	self.imgIconHead = UIControls.Image(self, "BgPanel/IconCircle")
	self.btnApply = UIControls.Button(self, "BgPanel/BtnApply", "Text")

	self.btnApply:addEventClick(self.onBtnApplyClick)

	self.txtTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnRefuse = UIControls.Button(self, "BtnRefuse")

	self.btnRefuse:addEventClick(self.onBtnRefuseClick)

	self.btnAgree = UIControls.Button(self, "BtnAgree")

	self.btnAgree:addEventClick(self.onBtnAgreeClick)

	self.panelHead = UIControls.Panel(self, "CircleHeadPanel")
end

function ShowCircleDlg:onBtnRefuseClick()
	if self.circle then
		RPC.clanFuncRefuseInvite(self.circle.gid)
		CurAvatar:tryCloseNoticeChild(self.circle.gid)
		self:setVisible(false)
	end
end

function ShowCircleDlg:onBtnAgreeClick()
	if self.circle then
		RPC.clanJoin(self.circle.gid, Const.CIRCLE_JOIN_TYPE_INVITE)
		CurAvatar:tryCloseNoticeChild(self.circle.gid)
		self:setVisible(false)
	end
end

function ShowCircleDlg:convertToInviteMode()
	self.btnAgree:setVisible(true)
	self.btnRefuse:setVisible(true)
	self.txtApplyPassContent:setVisible(false)
end

function ShowCircleDlg:setCircle(circle, isShowMode)
	self.circle = circle

	self.btnAgree:setVisible(false)
	self.btnRefuse:setVisible(false)
	self.txtApplyPassContent:setVisible(true)

	self.isShowMode = CurAvatar:isInCircle() and CurAvatar.myCircle ~= nil

	self.btnApply:setVisible(not self.isShowMode)

	self.beApplyed = CurAvatar:isCircleApplyed(self.circle.gid)

	local txtBtnApply = self.beApplyed and Lang.get(30174) or Lang.get(774)

	self.btnApply:setText(txtBtnApply)

	local titleStr = self.isShowMode and Lang.get(41692) or Lang.get(837)

	self.txtTitle:setText(titleStr)

	local applyPassText = self.circle.isAutoPass == 1 and Lang.get(30198) or Lang.get(30199)

	self.txtApplyPassContent:setText(applyPassText)
	self.txtName:setText(self.circle.name)
	self.txtActiveNum:setText(self.circle.weekExp)
	self.txtMemberCount:setText(self.circle.memberCount .. "/" .. self.circle:getCircleMaxMemberCount())
	self.txtId:setText(self.circle.gid)
	self.txtTitleContent:setText(self.circle.notice)
	self.txtLevel:setText(self.circle.level)

	if Const.FORCE_OPEN_CIRCLE_BATTLE then
		if not self.gridCircle then
			self.gridCircle = UIControls.GridCircleCommonChild(self, "CircleHeadPanel", "System/Common/Grid/GridCircleCommon", 0, 0, true)

			self.gridCircle.btnSelf:setEnable(false)
		end

		self.panelHead:setVisible(true)
		self.gridCircle:setCircle(self.circle)
		self.imgIconHead:setVisible(false)
	else
		local spriteInfo = self.circle:getCircleHeadPath()

		if spriteInfo then
			self.imgIconHead:setImage(spriteInfo[1], spriteInfo[2])
		end
	end

	self.btnMemberLeader = UIControls.BtnCircleMemberPanel(self, "BgPanel/BtnMember")

	self.btnMemberLeader:setMemberBaseData(self.circle:getCircleLeader())
	self.btnMemberLeader:setSelectCallback(Slot(self.onLeaderClick, self))
end

function ShowCircleDlg:onLeaderClick()
	CurAvatar:showPlayerTips(self.circle:getCircleLeader().base.uid, self)
end

function ShowCircleDlg:onBtnApplyClick()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_CIRCLE) then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_CIRCLE))

		return
	end

	if self.beApplyed then
		MsgManager.clientNotice(218)

		return
	end

	if not self.circle then
		return
	end

	if self.circle.memberCount == 0 then
		MsgManager.notice(Lang.get(30200))

		return
	end

	if self.circle.memberCount == self.circle:getCircleMaxMemberCount() then
		MsgManager.clientNotice(233)

		return
	end

	if CurAvatar:isEnterCircleInCD() and self.circle.isAutoPass == 1 then
		MsgManager.clientNotice(202)
	else
		RPC.clanJoin(self.circle.gid)

		local circleListDlg = UIManager.getUI("circleListDlg", nil, false)

		if circleListDlg then
			circleListDlg:refreshCircleList(circleListDlg.circleList)
		end
	end
end

function ShowCircleDlg:onBtnCloseClick()
	self:setVisible(false)
end

return ShowCircleDlg
