-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starhall/view/StarHallHudView.lua

module("logic.extensions.starhall.view.StarHallHudView", package.seeall)

local StarHallHudView = class("StarHallHudView", ViewComponent)

function StarHallHudView:ctor()
	StarHallHudView.super.ctor(self)
end

function StarHallHudView:unbindEvents()
	StarHallHudView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJumpRank)
	GameUtil.rmClickHandler(self._btnJumpExchange)
	GameUtil.rmClickHandler(self._btnFinal)
	GameUtil.rmClickHandler(self._btnStar)
end

function StarHallHudView:bindEvents()
	StarHallHudView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJumpRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnJumpExchange, self._onClickBtnExchange, self)
	GameUtil.addClickHandler(self._btnFinal, self._onClickBtnFinalEcho, self)
	GameUtil.addClickHandler(self._btnStar, self._onClickBtnStarHall, self)
end

function StarHallHudView:buildUI()
	StarHallHudView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnJumpExchange = self:getGo("btnJumpExchange")
	self._btnJumpRank = self:getGo("btnJumpRank")
	self._btnFinal = self:getGo("finalecholpart/btn")
	self._rankFinal = self:getGo("finalecholpart/rank")
	self._opentimeFinal = self:getGo("finalecholpart/opentime")
	self._txtOpentimeFinal = self:getTxt("finalecholpart/opentime/txt")
	self._endFinal = self:getGo("finalecholpart/end")
	self._emptyFinal = self:getGo("finalecholpart/rank/empty")
	self._firstPlayerFinal = self:getGo("finalecholpart/rank/firstPlayer")
	self._txtAreaFinal = self:getTxt("finalecholpart/rank/firstPlayer/txtArea")
	self._txtNameFinal = self:getTxt("finalecholpart/rank/firstPlayer/txtName")
	self._txtScoreFinal = self:getTxt("finalecholpart/rank/firstPlayer/txtScore")
	self._headIconFinal = self:getGo("finalecholpart/rank/firstPlayer/headIcon")
	self._rdFinal = self:getGo("finalecholpart/btn/rd")
	self._btnStar = self:getGo("starhallpart/btn")
	self._opentimeStar = self:getGo("starhallpart/opentime")
	self._txtOpentimeStar = self:getTxt("starhallpart/opentime/txt")
	self._endStar = self:getGo("starhallpart/end")
	self._rankStar = self:getGo("starhallpart/rank")
	self._emptyStar = self:getGo("starhallpart/rank/empty")
	self._firstPlayerStar = self:getGo("starhallpart/rank/firstPlayer")
	self._headIconStar = self:getGo("starhallpart/rank/firstPlayer/headIcon")
	self._txtAreaStar = self:getTxt("starhallpart/rank/firstPlayer/txtArea")
	self._txtNameStar = self:getTxt("starhallpart/rank/firstPlayer/txtName")
	self._txtScoreStar = self:getTxt("starhallpart/rank/firstPlayer/txtScore")
end

function StarHallHudView:onExit()
	StarHallHudView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headIconStar)
	HeadItemController.instance:resetHeadCell(self._headIconFinal)
	RedPointController.instance:unregRedPoint(self._rdFinal)
end

function StarHallHudView:onEnter()
	StarHallHudView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FinalEchoGetRankInfo, self._handleFinalEchoGetRankInfo, self)
	self.addGEvent(self, GlobalNotify.StarHallGetRankInfo, self._handleStarHallGetRankInfo, self)

	self._txtOpenTime.text = string.format("活动时间：%s", StarHallConfig.instance:getHudCommondValue("SHOW_ACTTIME"))
	self._finalAchoActId = self:getCurActId(StarHallConfig.instance:getHudCommondValue("FINAL_ECHO_ACTID"))
	self._starHallActId = self:getCurActId(StarHallConfig.instance:getHudCommondValue("STAR_HALL_ACTID"))

	self:_updateUI()
	RedPointController.instance:regRedPoint(self._rdFinal, 625)
end

function StarHallHudView:getCurActId(actStr)
	local curActId = 0
	local actIds = string.splitToNumber(actStr, "#")

	for _, actId in ipairs(actIds) do
		local activityType = ActivityDefineController.instance:getActTypeByActId(actId)
		local startTimeStamp, endTimeStamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, actId)
		local timePeriod = GameUtil.getTimePeriodTypeBySec(startTimeStamp, endTimeStamp)

		if timePeriod == GameUtil.beforeTimePeriod or timePeriod == GameUtil.inTimePeriod then
			return actId
		else
			curActId = actId
		end
	end

	return curActId
end

function StarHallHudView:_updateUI()
	if self._starHallActId < 0 then
		self._starHallTimePeriod = GameUtil.afterTimePeriod
	elseif ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._starHallActId) then
		self._starHallTimePeriod = GameUtil.inTimePeriod
	else
		local activityType = ActivityDefineController.instance:getActTypeByActId(self._starHallActId)
		local startTimeStamp, endTimeStamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, self._starHallActId)

		self._starHallTimePeriod = GameUtil.getTimePeriodTypeBySec(startTimeStamp, endTimeStamp)

		local startDate = GameUtil.time2date(startTimeStamp)

		self._txtOpentimeStar.text = string.format("%02d.%02d开启", startDate.month, startDate.day)
	end

	goutil.setActive(self._rankStar, false)
	goutil.setActive(self._opentimeStar, false)
	goutil.setActive(self._endStar, false)

	if self._starHallTimePeriod == GameUtil.inTimePeriod then
		StarHallController.instance:getRankInfo(self._starHallActId)
		goutil.setActive(self._rankStar, true)
	elseif self._starHallTimePeriod == GameUtil.beforeTimePeriod then
		goutil.setActive(self._opentimeStar, true)
	elseif self._starHallTimePeriod == GameUtil.afterTimePeriod then
		goutil.setActive(self._endStar, true)
	end

	if self._finalAchoActId < 0 then
		self._finalAchoTimePeriod = GameUtil.afterTimePeriod
	elseif ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._finalAchoActId) then
		self._finalAchoTimePeriod = GameUtil.inTimePeriod
	else
		local activityType = ActivityDefineController.instance:getActTypeByActId(self._finalAchoActId)
		local startTimeStamp, endTimeStamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, self._finalAchoActId)

		self._finalAchoTimePeriod = GameUtil.getTimePeriodTypeBySec(startTimeStamp, endTimeStamp)

		local startDate = GameUtil.time2date(startTimeStamp)

		self._txtOpentimeFinal.text = string.format("%02d.%02d开启", startDate.month, startDate.day)
	end

	goutil.setActive(self._rankFinal, false)
	goutil.setActive(self._opentimeFinal, false)
	goutil.setActive(self._endFinal, false)

	if self._finalAchoTimePeriod == GameUtil.inTimePeriod then
		FinalEchoController.instance:getRankInfo(self._finalAchoActId)
		goutil.setActive(self._rankFinal, true)
	elseif self._finalAchoTimePeriod == GameUtil.beforeTimePeriod then
		goutil.setActive(self._opentimeFinal, true)
	elseif self._finalAchoTimePeriod == GameUtil.afterTimePeriod then
		goutil.setActive(self._endFinal, true)
	end
end

function StarHallHudView:_handleFinalEchoGetRankInfo()
	HeadItemController.instance:resetHeadCell(self._headIconFinal)

	local info = FinalEchoModel.instance:getRankInfo(self._finalAchoActId)

	if info then
		if not info.rankInfos then
			local rankInfos = {}

			if #rankInfos > 0 then
				local firstRankInfo = rankInfos[1]
				local headInfo = firstRankInfo.headInfo

				HeadItemController.instance:setHeadCellByInfo(self._headIconFinal, headInfo, true)

				self._txtNameFinal.text = headInfo.userName

				goutil.setActive(self._emptyFinal, false)
				goutil.setActive(self._firstPlayerFinal, true)

				self._txtScoreFinal.text = string.format("累计积分：%s", firstRankInfo.value)
				self._txtAreaFinal.text = string.format("%s-%s", headInfo.areaId, headInfo.areaName)
			else
				goutil.setActive(self._emptyFinal, true)
				goutil.setActive(self._firstPlayerFinal, false)
			end
		end
	end
end

function StarHallHudView:_handleStarHallGetRankInfo()
	HeadItemController.instance:resetHeadCell(self._headIconStar)

	local info = StarHallModel.instance:getRankInfo(self._starHallActId)

	if info then
		if not info.rankInfos then
			local rankInfos = {}

			if #rankInfos > 0 then
				local firstRankInfo = rankInfos[1]
				local headInfo = firstRankInfo.headInfo

				HeadItemController.instance:setHeadCellByInfo(self._headIconStar, headInfo, true)
				goutil.setActive(self._emptyStar, false)
				goutil.setActive(self._firstPlayerStar, true)

				self._txtNameStar.text = headInfo.userName
				self._txtScoreStar.text = string.format("累计积分：%s", firstRankInfo.value)
				self._txtAreaStar.text = string.format("%s-%s", headInfo.areaId, headInfo.areaName)
			else
				goutil.setActive(self._emptyStar, true)
				goutil.setActive(self._firstPlayerStar, false)
			end
		end
	end
end

function StarHallHudView:_onClickBtnTip()
	local key = StarHallConfig.instance:getHudCommondValue("RULE_KEY")

	TipsFacade.instance:openRulesView(key)
end

function StarHallHudView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.FinalEchoRankMainView)
end

function StarHallHudView:_onClickBtnExchange()
	local jumpToStr = StarHallConfig.instance:getHudCommondValue("EXCHANGE_JUMP_STR")

	GotoMgr.gotoByString(jumpToStr)
end

function StarHallHudView:_onClickBtnStarHall()
	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._starHallActId) then
		if self._starHallTimePeriod ~= GameUtil.inTimePeriod then
			self:_updateUI()
		end

		UIStateManager.instance:push(ViewName.StarHallView, self._starHallActId)
	else
		if self._starHallTimePeriod == GameUtil.inTimePeriod then
			self:_updateUI()
		end

		if self._starHallTimePeriod == GameUtil.beforeTimePeriod then
			TipsFacade.instance:openCommonTips(self._txtOpentimeStar.text)
		elseif self._starHallTimePeriod == GameUtil.afterTimePeriod then
			TipsFacade.instance:openCommonTips("活动已结束")
		end
	end
end

function StarHallHudView:_onClickBtnFinalEcho()
	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._finalAchoActId) then
		if self._finalAchoTimePeriod ~= GameUtil.inTimePeriod then
			self:_updateUI()
		end

		UIStateManager.instance:push(ViewName.FinalEchoMainView, self._finalAchoActId)
	else
		if self._finalAchoTimePeriod == GameUtil.inTimePeriod then
			self:_updateUI()
		end

		if self._finalAchoTimePeriod == GameUtil.beforeTimePeriod then
			TipsFacade.instance:openCommonTips(self._txtOpentimeFinal.text)
		elseif self._finalAchoTimePeriod == GameUtil.afterTimePeriod then
			TipsFacade.instance:openCommonTips("活动已结束")
		end
	end
end

return StarHallHudView
