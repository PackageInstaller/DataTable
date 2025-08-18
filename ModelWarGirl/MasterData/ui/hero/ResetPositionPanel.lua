-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ResetPositionPanel.lua

local RESET_POS_STATUS_IN_CD = 1
local RESET_POS_STATUS_CAN_USE = 2
local RESET_POS_STATUS_LOCK = 3
local ResHeroResetMisc = require("ClientData/ResHeroResetMisc")
local strClassName = "ResetPos"
local ResetPos = Class(strClassName, UIControls.Panel)

function ResetPos:ctor()
	self:initUI()
end

function ResetPos:initUI()
	self.bgTime = UIControls.Panel(self, self.mPath .. "/BgTime")
	self.bgUsable = UIControls.Panel(self, self.mPath .. "/BgUsable")
	self.imgUsableNml = UIControls.Panel(self, self.mPath .. "/BgUsable/BgUsableNml")
	self.imgUsableSel = UIControls.Panel(self, self.mPath .. "/BgUsable/BgUsableSel")
	self.bgLock = UIControls.Panel(self, self.mPath .. "/BgLock")
	self.txtRemainCD = UIControls.Label(self, self.mPath .. "/BgTime/TextTime")
	self.btnSelf = UIControls.Button(self, self.mPath)

	self.btnSelf:addEventClick(self.onBtnSelfClick)
end

function ResetPos:setUsableSel(isSel)
	self.bgUsable:setVisible(true)
	self.imgUsableSel:setVisible(isSel)
	self.imgUsableNml:setVisible(not isSel)
end

function ResetPos:setStatusInfo(statusInfo)
	self.statusInfo = statusInfo

	local isLocked = false

	if self.statusInfo.limitId ~= 0 then
		isLocked = ConditionLimitManager.inLimitState(self.statusInfo.limitId)
	end

	if isLocked then
		self.status = RESET_POS_STATUS_LOCK
	elseif self.statusInfo.nextTick == 0 or ClientUtils.getServerTime() >= self.statusInfo.nextTick then
		self.status = RESET_POS_STATUS_CAN_USE
	else
		self.status = RESET_POS_STATUS_IN_CD
	end

	if self.status == RESET_POS_STATUS_CAN_USE then
		self.bgTime:setVisible(false)
		self.bgLock:setVisible(false)
		self:setUsableSel(false)
		ClientTimerManager.RemoveSecondTickUI(self.txtRemainCD)
	elseif self.status == RESET_POS_STATUS_IN_CD then
		self.bgTime:setVisible(true)
		self.bgUsable:setVisible(false)
		self.bgLock:setVisible(false)

		local remainTime = self.statusInfo.nextTick - ClientUtils.getServerTime()

		ClientTimerManager.AddSecondTickUI(self.txtRemainCD, remainTime, false, "", "", Slot(self.timeEndEvent, self))
	else
		ClientTimerManager.RemoveSecondTickUI(self.txtRemainCD)
		self.bgTime:setVisible(false)
		self.bgUsable:setVisible(false)
		self.bgLock:setVisible(true)
	end
end

function ResetPos:setTimeEndCallBack(timeEndCallBack)
	self.timeEndCallBack = timeEndCallBack
end

function ResetPos:timeEndEvent()
	if self.statusInfo and self.timeEndCallBack then
		self.timeEndCallBack(self)
	end
end

function ResetPos:onBtnSelfClick()
	if self.status == RESET_POS_STATUS_LOCK then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(self.statusInfo.limitId))
	elseif self.status == RESET_POS_STATUS_IN_CD then
		MsgManager.clientNotice(272)
	end
end

local strClassName = "ResetPositionPanel"
local ResetPositionPanel = Class(strClassName, UIControls.Panel)

function ResetPositionPanel:ctor()
	self:initUI()
end

function ResetPositionPanel:initUI()
	self.btnTips = UIControls.Button(self, self.mPath .. "/BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.posPanelList = {}

	for i = 1, 3 do
		local posPanel = ResetPos(self, self.mPath .. "/PositionPanel/Position" .. i)

		self.posPanelList[i] = posPanel
	end
end

function ResetPositionPanel:getNearUnlockedPosLimitId()
	for i, posPanel in ipairs(self.posPanelList) do
		if posPanel.status == RESET_POS_STATUS_LOCK then
			return posPanel.statusInfo.limitId
		end
	end
end

function ResetPositionPanel:setHero(hero)
	self.hero = hero

	local haveUsable = false

	for pos, posPanel in ipairs(self.posPanelList) do
		local statusInfo = {}

		statusInfo.limitId = ResHeroResetMisc[2].condition_id[pos]
		statusInfo.nextTick = CurAvatar:getNextStepTick(pos)

		posPanel:setStatusInfo(statusInfo)
		posPanel:setTimeEndCallBack(Slot(self.resetPosTimeEnd, self))

		if not haveUsable and posPanel.status == RESET_POS_STATUS_CAN_USE then
			posPanel:setUsableSel(true)

			haveUsable = true
		end
	end
end

function ResetPositionPanel:resetPosTimeEnd(resetPos)
	local haveUsable = false

	for pos, posPanel in ipairs(self.posPanelList) do
		if posPanel == resetPos then
			posPanel.status = RESET_POS_STATUS_CAN_USE

			posPanel.bgTime:setVisible(false)
		end

		if not haveUsable and posPanel.status == RESET_POS_STATUS_CAN_USE then
			posPanel:setUsableSel(true)

			haveUsable = true
		end
	end
end

function ResetPositionPanel:getUsablePos()
	for pos, posPanel in ipairs(self.posPanelList) do
		if posPanel.status == RESET_POS_STATUS_CAN_USE then
			return pos
		end
	end
end

function ResetPositionPanel:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_STEP_RESET)
end

return ResetPositionPanel
