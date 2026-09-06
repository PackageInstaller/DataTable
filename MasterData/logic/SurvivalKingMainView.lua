-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingMainView.lua

module("logic.extensions.survivalking.view.SurvivalKingMainView", package.seeall)

local SurvivalKingMainView = class("SurvivalKingMainView", ViewComponent)

function SurvivalKingMainView:ctor()
	SurvivalKingMainView.super.ctor(self)
end

function SurvivalKingMainView:unbindEvents()
	SurvivalKingMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnOb)
	GameUtil.rmClickHandler(self._btnJumpPicRule)
	GameUtil.rmClickHandler(self._btnJumpTask)
	GameUtil.rmClickHandler(self._btnTimetips)
end

function SurvivalKingMainView:bindEvents()
	SurvivalKingMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickJump1, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickJump2, self)
	GameUtil.addClickHandler(self._btnJump3, self._onClickJump3, self)
	GameUtil.addClickHandler(self._btnJump4, self._onClickJump4, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickBtnChange, self)
	GameUtil.addClickHandler(self._btnOb, self._onClickBtnOb, self)
	GameUtil.addClickHandler(self._btnJumpPicRule, self._onClickPicRule, self)
	GameUtil.addClickHandler(self._btnJumpTask, self._onClickJumpTask, self)
	GameUtil.addClickHandler(self._btnTimetips, self._onClickTimetips, self)
end

function SurvivalKingMainView:buildUI()
	SurvivalKingMainView.super.buildUI(self)

	self._btnChange = self:getGo("btnChange")
	self._btnOb = self:getGo("btnOb")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnJumpPicRule = self:getGo("jumpBtnCol/btnJumpPicRule")
	self._btnJumpTask = self:getGo("jumpBtnCol/btnJumpTask")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._markProgress = self:getGo("markProgress")
	self._txtLeftTime = self:getTxt("txtLeftTime")
	self._txtCurSessionId = self:getTxt("txtCurSessionId")
	self._txtTips = self:getTxt("txtTips")
	self._txtCountDown = self:getTxt("txtCountDown")
	self._con = self:getGo("con")
	self._redPointJump4 = self:getGo("jumpBtnCol/btnJump4/redPoint")
	self._redPointJumpTask = self:getGo("jumpBtnCol/btnJumpTask/redPoint")
	self._btnTimetips = self:getGo("btnTimetips")
	self._tip = self:getGo("jumpBtnCol/btnJump4/tip")
end

function SurvivalKingMainView:onExit()
	SurvivalKingMainView.super.onExit(self)
	removetimer(self._updateUIByTime, self)
	removetimer(self._onCountDown, self)
	removetimer(self._onCountDown1, self)
	removetimer(self._onCountDown2, self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	RedPointController.instance:unregRedPoint(self._redPointJump4)
	RedPointController.instance:unregRedPoint(self._redPointJumpTask)
end

function SurvivalKingMainView:onEnter()
	SurvivalKingMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SurvivalKingGetBaseInfo, self._updateUIByInfo, self)

	self._activityId = 529002

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self:_updateUIByTime()
	SurvivalKingController.instance:getBaseInfo(self._activityId)
	SurvivalKingController.instance:sendGetPresetInfo(self._activityId)

	local function updateTip()
		local prizeInfo = SurvivalKingModel.instance:getPrizeInfo(self._activityId)

		if prizeInfo then
			::label_7_0::

			local var_7_0 = prizeInfo.prizes

			if prizeInfo.prizes then
				local hasPrize = #prizeInfo.prizes > 0

				goutil.setActive(self._tip, hasPrize)
			end
		end
	end

	self.addGEvent(self, GlobalNotify.SurvivalKingGetPrizeInfo, updateTip, self)
	self.addGEvent(self, GlobalNotify.SurvivalKingGainPrize, updateTip, self)
	SurvivalKingController.instance:getPrizeInfo(self._activityId)
	updateTip()

	local key = string.format("%s_rule_%s", self._viewPresentor.viewName, self._activityId)

	GameUtil.doCallbackWhenFirst(key, function()
		self:_onClickPicRule()
	end)
	RedPointController.instance:regRedPoint(self._redPointJump4, self._actCfg.redPointId)

	if not self._actCfg.taskPointId then
		if self._actCfg.taskPointId > 0 then
			RedPointController.instance:regRedPoint(self._redPointJumpTask, self._actCfg.taskPointId)
		else
			GameUtil.SetActive(self._redPointJumpTask, false)
		end
	end
end

function SurvivalKingMainView:_updateUIByCfg()
	self._actCfg = SurvivalKingConfig.instance:getActivityCfg(self._activityId)
	self._sessionCfgs = SurvivalKingConfig.instance:getAllSessionCfg(self._activityId) or {}
	self._prizeTimeMax = self._actCfg.prizeTimes or 0
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._OpenTime = self._actCfg.openTime or ""
	self._EndTime = self._actCfg.endTime or ""

	local timeLimitStart = "0-0-0 " .. self._OpenTime
	local timeLimitEnd = "0-0-0 " .. self._EndTime
	local dateStart = GameUtil.string2date(timeLimitStart)
	local dateEnd = GameUtil.string2date(timeLimitEnd)

	self._txtTips.text = string.format("每日%02d:%02d-%02d:%02d开放", dateStart.hour, dateStart.min, dateEnd.hour, dateEnd.min)

	local skinId = self._actCfg.skinId

	if skinId > 0 then
		local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", skinId)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])
	end

	self._timeTipsStr = ""

	for i, cfg in ipairs(self._sessionCfgs) do
		self._timeTipsStr = self._timeTipsStr .. string.format("第%d场：%s\n", i, cfg.sessionName)
	end
end

function SurvivalKingMainView:_updateUIByInfo()
	self._hasSignInTime = 0
	self._hasSignMap = {}

	local baseInfo = SurvivalKingModel.instance:getBaseInfo(self._activityId)

	if baseInfo then
		if not baseInfo.signUps then
			for _, v in ipairs(baseInfo.signUps) do
				if v.signUp == true then
					self._hasSignMap[v.sessionId] = true
					self._hasSignInTime = self._hasSignInTime + 1
				end
			end
		end
	end

	self._txtLeftTime.text = string.format("今日奖励次数：<color=#feeea4>%d</color>/%d", Mathf.Max(self._prizeTimeMax - self._hasSignInTime, 0), self._prizeTimeMax)
end

function SurvivalKingMainView:_updateUIByTime()
	self._timeStatus, self._freshTime = SurvivalKingController.instance:getCurStatusByTime(self._activityId)
	self._curSessionId = 0

	local curTime = ServerTime.now()

	removetimer(self._updateUIByTime, self)
	removetimer(self._onCountDown, self)
	removetimer(self._onCountDown1, self)

	local timer = self._freshTime - curTime

	if timer > 0 then
		settimer(timer, self._updateUIByTime, self, true)
	end

	local sessionCfg = SurvivalKingController.instance:getCurSessionCfg(self._activityId)

	self._txtCurSessionId.text = ""
	self._txtCountDown.text = ""

	goutil.setActive(self._markProgress, false)

	if self._timeStatus == SurvivalKingController.TimeStatus.NotOpen then
		self._txtCurSessionId.text = string.format("下一场次：%s", (sessionCfg or nil) and (sessionCfg.sessionName or "无"))
	elseif self._timeStatus == SurvivalKingController.TimeStatus.SignUp then
		self._txtCurSessionId.text = string.format("下一场次：%s", (sessionCfg or nil) and (sessionCfg.sessionName or "无"))

		settimer(1, self._onCountDown, self, true)
	elseif self._timeStatus == SurvivalKingController.TimeStatus.RegistrationClosed then
		self._txtCurSessionId.text = string.format("下一场次：%s", (sessionCfg or nil) and (sessionCfg.sessionName or "无"))

		settimer(1, self._onCountDown1, self, true)
	elseif self._timeStatus == SurvivalKingController.TimeStatus.InProgress then
		goutil.setActive(self._markProgress, true)

		self._txtCurSessionId.text = string.format("当前场次：%s", (sessionCfg or nil) and (sessionCfg.sessionName or "无"))
		self._curSessionId = sessionCfg.sessionId

		if self._hasSignMap[self._curSessionId] then
			self._txtCountDown.text = "已报名该场次，可前往观战！"
		else
			self._txtCountDown.text = ""

			settimer(1, self._onCountDown2, self, true)
		end
	elseif self._timeStatus == SurvivalKingController.TimeStatus.Ended then
		-- block empty
	elseif self._timeStatus == SurvivalKingController.TimeStatus.AllEnded then
		-- block empty
	end
end

function SurvivalKingMainView:_onCountDown()
	local curTime = ServerTime.now()
	local timer = self._freshTime - curTime

	if timer >= 0 then
		local timeFormat = TimeUtil:timeConvert2(timer, "HH:MM:SS", true)

		self._txtCountDown.text = string.format("距离报名结束还有：%s", timeFormat)
	else
		self._txtCountDown.text = ""

		removetimer(self._onCountDown, self)
	end
end

function SurvivalKingMainView:_onCountDown1()
	local curTime = ServerTime.now()
	local timer = self._freshTime - curTime

	if timer >= 0 then
		local timeFormat = TimeUtil:timeConvert2(timer, "HH:MM:SS", true)

		self._txtCountDown.text = string.format("距离战斗开始还有：%s", timeFormat)
	else
		self._txtCountDown.text = ""

		removetimer(self._onCountDown1, self)
	end
end

function SurvivalKingMainView:_onCountDown2()
	local curTime = ServerTime.now()
	local timer = self._freshTime - curTime

	if timer >= 0 then
		local timeFormat = TimeUtil:timeConvert2(timer, "HH:MM:SS", true)

		self._txtCountDown.text = string.format("下场报名开始：%s", timeFormat)
	else
		self._txtCountDown.text = ""

		removetimer(self._onCountDown2, self)
	end
end

function SurvivalKingMainView:_onClickBtnChange()
	if self._timeStatus == SurvivalKingController.TimeStatus.NotOpen then
		TipsFacade.instance:openCommonTips(self._txtTips.text)

		return
	elseif self._timeStatus == SurvivalKingController.TimeStatus.AllEnded then
		TipsFacade.instance:openCommonTips(self._txtTips.text)

		return
	end

	if SurvivalKingConfig.instance:isBuffMode(self._activityId, SurvivalKingController.BuffMode.Level) then
		UIStateManager.instance:push(ViewName.SurvivalKingLevelPresetView, self._activityId)
	else
		UIStateManager.instance:push(ViewName.SurvivalKingPresetView, self._activityId)
	end
end

function SurvivalKingMainView:_onClickBtnOb()
	if self._timeStatus ~= SurvivalKingController.TimeStatus.InProgress then
		TipsFacade.instance:openCommonTips("当前没有进行中的场次")

		return
	end

	UIStateManager.instance:push(ViewName.SurvivalKingRoomView, self._activityId, self._curSessionId)
end

function SurvivalKingMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function SurvivalKingMainView:_onClickJump1()
	UIStateManager.instance:push(ViewName.SurvivalKingRankView, self._activityId)
end

function SurvivalKingMainView:_onClickJump2()
	UIStateManager.instance:push(ViewName.SurvivalKingBattleLogView, self._activityId)
end

function SurvivalKingMainView:_onClickJump3()
	local jumpToStr = self._actCfg.gotoExchange

	GotoMgr.gotoByString(jumpToStr)
end

function SurvivalKingMainView:_onClickJump4()
	UIStateManager.instance:push(ViewName.SurvivalKingPrizeView, self._activityId)
end

function SurvivalKingMainView:_onClickJumpTask()
	local jumpToStr = self._actCfg.gotoTask

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function SurvivalKingMainView:_onClickPicRule()
	local ruleKey = self._actCfg.picRuleKey

	TipsFacade.instance:openImageRuleViewByKey(ruleKey, "游戏规则")
end

function SurvivalKingMainView:_onClickTimetips()
	TipsFacade.instance:openTipWindowNoX("场次时间", self._timeTipsStr, nil, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

return SurvivalKingMainView
