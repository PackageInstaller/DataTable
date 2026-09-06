-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/view/SpringRedPackHudView.lua

module("logic.extensions.springredpack.view.SpringRedPackHudView", package.seeall)

local SpringRedPackHudView = class("SpringRedPackHudView", ViewComponent)

SpringRedPackHudView.DailyPack1 = 1
SpringRedPackHudView.DailyPack2 = 2

function SpringRedPackHudView:ctor()
	SpringRedPackHudView.super.ctor(self)
end

function SpringRedPackHudView:buildUI()
	SpringRedPackHudView.super.buildUI(self)

	self._txtRound = self:getTxt("btns/btnRound/tip/txt")
	self._btnRound = self:getBtn("btns/btnRound")
	self._btnDaily = self:getBtn("btns/btnDaily")
	self._txtRoundPack = self:getTxt("btnRoundPack/tip/txt")
	self._btnRoundPack = self:getBtn("btnRoundPack")
	self._btnDayPack = self:getBtn("btnDayPack")
end

function SpringRedPackHudView:bindEvents()
	SpringRedPackHudView.super.bindEvents(self)
	self._btnRound:AddClickListener(self._onClickRoundRedPack, self)
	self._btnDaily:AddClickListener(self._onClickDailyRedPack, self)
	self._btnRoundPack:AddClickListener(self._onClickRoundRedPack, self)
	self._btnDayPack:AddClickListener(self._onClickDailyRedPack, self)
end

function SpringRedPackHudView:unbindEvents()
	SpringRedPackHudView.super.unbindEvents(self)
	self._btnRound:RemoveClickListener()
	self._btnDaily:RemoveClickListener()
	self._btnRoundPack:RemoveClickListener()
	self._btnDayPack:RemoveClickListener()
end

function SpringRedPackHudView:onEnter()
	SpringRedPackHudView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GetRedPackInfoRes, self._onGetRankInfoRes, self)

	self._dailyPackType = self:getFirstParam() or SpringRedPackHudView.DailyPack1

	goutil.setActive(self._btnRound.gameObject, false)
	goutil.setActive(self._btnDaily.gameObject, false)
	goutil.setActive(self._btnDayPack.gameObject, false)
	goutil.setActive(self._btnRoundPack.gameObject, false)

	self._lastState = -1

	self:_onSecond()
	settimer(1, self._onSecond, self)

	self._lastState = SpringRedPackModel.instance:getCurRedPackState()

	local roundId = SpringRedPackModel.instance:getCurRoundId()
	local activityId = SpringRedPackModel.instance:getCurActivityId()

	SpringRedPackAgent.instance:sendPM_GetRedPackInfoReq(activityId, roundId)
end

function SpringRedPackHudView:onExit()
	SpringRedPackHudView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GetRedPackInfoRes, self._onGetRankInfoRes, self)
	removetimer(self._onSecond, self)
end

function SpringRedPackHudView:_onClickRoundRedPack()
	local curState = SpringRedPackModel.instance:getCurRedPackState()

	if curState == SpringRedPackModel.None then
		FloatWordMgr.instance:show("未在活动时间")
	elseif curState == SpringRedPackModel.Countdown then
		if not ViewMgr.instance:isOpen(ViewName.SpringRedPackInfoView) then
			UIStateManager.instance:push(ViewName.SpringRedPackInfoView, true)
		end
	elseif curState == SpringRedPackModel.StartRedPack then
		if SpringRedPackModel.instance:isUseAllRedPackCount() then
			FloatWordMgr.instance:show("红包次数已用完了哦")
		elseif SpringRedPackModel.instance:isGainThisRound() then
			FloatWordMgr.instance:show("本轮红包已领取哦")
		else
			UIStateManager.instance:push(ViewName.SpringRedPackSelectView, SpringRedPackModel.RedPackType.RoundRedPack)
		end
	end
end

function SpringRedPackHudView:_onClickDailyRedPack()
	if SpringRedPackModel.instance:isGainDailyPrize() then
		FloatWordMgr.instance:show("每日红包已领取哦")

		return
	end

	UIStateManager.instance:push(ViewName.SpringRedPackSelectView, SpringRedPackModel.RedPackType.DailyRedPack)
end

function SpringRedPackHudView:_onGetRankInfoRes()
	self:_updateRoundRedPackState()
end

function SpringRedPackHudView:_onSecond()
	self:_updateRoundRedPackState()
	self:_updateDailyRedPackState()
end

function SpringRedPackHudView:_updateRoundRedPackState()
	local curState = SpringRedPackModel.instance:getCurRedPackState()

	if self._lastState ~= curState then
		self._lastState = curState

		if curState == SpringRedPackModel.StartRedPack then
			local roundId = SpringRedPackModel.instance:getCurRoundId()
			local activityId = SpringRedPackModel.instance:getCurActivityId()

			SpringRedPackAgent.instance:sendPM_GetRedPackInfoReq(activityId, roundId)
		end
	end

	if curState == SpringRedPackModel.None then
		self:_setBtnRound(false)
	elseif curState == SpringRedPackModel.Countdown then
		if SpringRedPackModel.instance:isUseAllRedPackCount() then
			self:_setBtnRound(false)
		else
			self:_setBtnRound(true)

			self._txtRound.text = self:_getTxtOnCountdown()
			self._txtRoundPack.text = self._txtRound.text
		end
	elseif curState == SpringRedPackModel.StartRedPack then
		if SpringRedPackModel.instance:isUseAllRedPackCount() or SpringRedPackModel.instance:isGainThisRound() then
			self:_setBtnRound(false)
		else
			self:_setBtnRound(true)

			self._txtRound.text = "红包发放中"
			self._txtRoundPack.text = self._txtRound.text
		end
	end
end

function SpringRedPackHudView:_setBtnRound(isOpen)
	if self._dailyPackType == SpringRedPackHudView.DailyPack1 then
		goutil.setActive(self._btnRound.gameObject, isOpen)
		goutil.setActive(self._btnRoundPack.gameObject, false)
	else
		goutil.setActive(self._btnRoundPack.gameObject, isOpen)
		goutil.setActive(self._btnRound.gameObject, false)
	end
end

function SpringRedPackHudView:_updateDailyRedPackState()
	if SpringRedPackController.instance:isInActivityTime() then
		local isOpen = not SpringRedPackModel.instance:isGainDailyPrize()

		if self._dailyPackType == SpringRedPackHudView.DailyPack1 then
			goutil.setActive(self._btnDaily.gameObject, isOpen)
		else
			goutil.setActive(self._btnDayPack.gameObject, isOpen)
		end
	else
		goutil.setActive(self._btnDaily.gameObject, false)
		goutil.setActive(self._btnDayPack.gameObject, false)
	end
end

function SpringRedPackHudView:_getTxtOnCountdown()
	local activityId = SpringRedPackModel.instance:getCurActivityId()
	local roundId = SpringRedPackModel.instance:getCurRoundId()
	local cfgRound = SpringRedPackConfig.instance:getRoundCfg(activityId, roundId)

	if cfgRound then
		local curTime = ServerTime.now()
		local beginTime = GameUtil.string2time(cfgRound.roundBeginTime)
		local leftTime = beginTime - curTime

		leftTime = leftTime > 0 and leftTime or 0

		return string.format("%s后发放红包", GameUtil.FormatTimeSymbol(leftTime))
	else
		return ""
	end
end

return SpringRedPackHudView
