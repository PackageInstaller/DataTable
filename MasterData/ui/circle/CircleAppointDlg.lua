-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleAppointDlg.lua

local strClassName = "CircleAppointDlg"
local CircleAppointDlg = Class(strClassName, UIControls.Window)

function CircleAppointDlg:ctor()
	self:initUI()
end

function CircleAppointDlg:initUI()
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnDeny = UIControls.Button(self, "BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.txtTips = UIControls.Label(self, "TextTips")
	self.badageInfoList = {}

	for i = 1, 3 do
		local btnBadage = UIControls.Button(self, "Bg/BadgePanel/BtnBadge" .. i)

		btnBadage:addEventClick(self.onBtnBadageClick)

		self.badageInfoList[i] = btnBadage
	end
end

function CircleAppointDlg:setManagedMember(managedMember)
	self.managedMember = managedMember

	for appoint, duty in pairs(Const.APPOINT_DUTY_DIC) do
		if CurAvatar:getMyDutyPermission()[appoint] and self.managedMember.duty ~= duty then
			self.badageInfoList[duty]:setVisible(true)
		else
			self.badageInfoList[duty]:setVisible(false)
		end
	end

	for duty, _ in ipairs(self.badageInfoList) do
		if self.badageInfoList[duty]:getVisible() then
			self:onBtnBadageClick(self.badageInfoList[duty])

			break
		end
	end

	local name, serverName = utils.GetPlayerName(self.managedMember.base.name)

	self.txtTips:setText(string.format(Lang.get(30177), name))
end

function CircleAppointDlg:onBtnConfirmClick()
	if self.selectBadageIdx ~= Const.CIRCLE_DUTY_BOSS then
		if self.selectBadageIdx == Const.CIRCLE_DUTY_ASSISTANT then
			if CurAvatar.myCircle:getAssistantCounts() >= Const.CIRCLE_MAX_ASSISTANT_COUNT then
				MsgManager.clientNotice(220)

				return
			end
		elseif self.selectBadageIdx == Const.CIRCLE_DUTY_MANAGER and CurAvatar.myCircle:getManagerCounts() >= Const.CIRCLE_MAX_MANAGER_COUNT then
			MsgManager.clientNotice(221)

			return
		end

		RPC.clanAppoint(self.managedMember.base.uid, self.selectBadageIdx)
	else
		RPC.clanTransfer(self.managedMember.base.uid)
	end
end

function CircleAppointDlg:onBtnDenyClick()
	self:setVisible(false)
end

function CircleAppointDlg:onBtnBadageClick(sender)
	for idx, badageInfo in ipairs(self.badageInfoList) do
		badageInfo:setEnable(sender ~= badageInfo)

		if sender == badageInfo then
			self.selectBadageIdx = idx
		end
	end
end

return CircleAppointDlg
