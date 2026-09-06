-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/peakdiamond/PeakDiamondView.lua

module("logic.extensions.bonus.view.peakdiamond.PeakDiamondView", package.seeall)

local PeakDiamondView = class("PeakDiamondView", ViewComponent)

function PeakDiamondView:ctor()
	PeakDiamondView.super.ctor(self)
end

function PeakDiamondView:bindEvents()
	PeakDiamondView.super.bindEvents(self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "peakdiamond")
	end, self)
	self._participateBtn:AddClickListener(function()
		SurveyController.instance:reportBehavior(SurveyBehaviorID.PeakDiamondJumpTo_1)
		GotoMgr.gotoByString(self._actCfg.dfJumpTo)
	end, self)
	self._activationBtn:AddClickListener(self._onClickActivationBtn, self)
end

function PeakDiamondView:unbindEvents()
	PeakDiamondView.super.unbindEvents(self)
	self._tipsBtn:RemoveClickListener()
	self._participateBtn:RemoveClickListener()
	self._activationBtn:RemoveClickListener()
end

function PeakDiamondView:onExit()
	PeakDiamondView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataPeakDiamondInfo, self._updateViewInfoShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataPeakDiamondPrize, self._updataReceiveAlreadyAward, self)
	MaterialMgr.resetAll(self._headGo)
	MaterialMgr.resetAll(self._goodsGo)
end

function PeakDiamondView:destroyUI()
	PeakDiamondView.super.destroyUI(self)
end

function PeakDiamondView:buildUI()
	PeakDiamondView.super.buildUI(self)

	self._tipsBtn = self:getBtn("tipsBtn")
	self._timeTxt = self:getTxt("timeGo/timeTxt")

	local rankGo = self:getGo("rankGo")

	self._headGo = goutil.findChild(rankGo, "headGo")
	self._userTxt = goutil.findChildTextComponent(rankGo, "userTxt")
	self._emptyGo = goutil.findChild(rankGo, "emptyGo")
	self._participateBtn = Framework.ButtonAdapter.GetFrom(rankGo, "participateBtn")

	local taskGo = self:getGo("taskGo")

	self._taskImaGo1 = goutil.findChild(taskGo, "taskTxt1/taskImaGo")
	self._taskImaGo2 = goutil.findChild(taskGo, "taskTxt2/taskImaGo")
	self._goodsGo = goutil.findChild(taskGo, "goodsGo")
	self._receiveGo = goutil.findChild(taskGo, "receiveGo")
	self._taskDescTxt = goutil.findChildTextComponent(taskGo, "taskDescTxt")
	self._activationBtn = Framework.ButtonAdapter.GetFrom(taskGo, "activationBtn")
	self._activationTxt = goutil.findChildTextComponent(self._activationBtn.gameObject, "activationTxt")
	self._redpointGo = goutil.findChild(self._activationBtn.gameObject, "redpointGo")
	self._taskDescTxt.text = ""
	self._timeTxt.text = ""
	self._userTxt.text = ""

	GameUtil.SetActive(self._taskImaGo1, false)
	GameUtil.SetActive(self._taskImaGo2, false)
	GameUtil.SetActive(self._receiveGo, false)
	GameUtil.SetActive(self._emptyGo, false)
	GameUtil.SetActive(self._redpointGo, false)
end

function PeakDiamondView:onEnter()
	PeakDiamondView.super.onEnter(self)
	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataPeakDiamondInfo, self._updateViewInfoShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataPeakDiamondPrize, self._updataReceiveAlreadyAward, self)

	local actId = PeakDiamondConfig.instance:getPeakDiamondActivityId()

	if checknumber(actId) <= 0 then
		self:close()

		return
	end

	self._actCfg = PeakDiamondConfig.instance:getPeakDiamondActivityCfg(actId)
	self._timeTxt.text = self._actCfg.timeShow

	GameUtil.SetActive(self._taskImaGo1, false)
	GameUtil.SetActive(self._taskImaGo2, false)
	MaterialMgr.setCellByCfg(self._actCfg.returnPrize, self._goodsGo)
	self:_updateViewInfoShow({
		hasGained = false,
		isTopArea = false,
		buyTime = 0
	})
	PeakReturnAgent.instance:sendPM_PeakReturnGetInfoReq(self._actCfg.activityId)
end

function PeakDiamondView:_updateViewInfoShow(data)
	removetimer(self._calculationSurplusTime, self)
	MaterialMgr.resetAll(self._headGo)

	self._baseInfo = data or {}

	if self._baseInfo.top and self._baseInfo.top.headInfo then
		GameUtil.SetActive(self._emptyGo, false)
		HeadItemController.instance:setHeadCellByInfo(self._headGo, self._baseInfo.top.headInfo)

		self._userTxt.text = self._baseInfo.top.headInfo.userName
	else
		self._userTxt.text = "虚位以待"

		GameUtil.SetActive(self._emptyGo, true)
	end

	GameUtil.SetActive(self._taskImaGo2, self._baseInfo.isTopArea)
	GameUtil.SetActive(self._receiveGo, self._baseInfo.hasGained)
	self:_updataReceiveAlreadyAward(self._baseInfo.hasGained)
end

function PeakDiamondView:_updataReceiveAlreadyAward(isReceive)
	self._baseInfo.hasGained = isReceive

	local endTime = GameUtil.string2time(self._actCfg.conditionTime)
	local nowTime = ServerTime.now()
	local buyTime = math.floor(checknumber(self._baseInfo.buyTime) / 1000)

	GameUtil.SetActive(self._redpointGo, false)

	if nowTime < endTime then
		self._supTime = endTime - nowTime

		self:_showSurplusTimeText()
		settimer(1, self._calculationSurplusTime, self, true)

		self._activationTxt.text = buyTime > 0 and "已激活" or "前往激活"

		GameUtil.SetActive(self._taskImaGo1, buyTime > 0)
	else
		if buyTime > 0 and buyTime <= endTime then
			GameUtil.SetActive(self._taskImaGo1, true)
		else
			GameUtil.SetActive(self._taskImaGo1, false)
		end

		local dfsCfg = PeakTournamentConfig.instance:getPtBaseData(self._actCfg.peakTournamentActId)
		local isDfsEnd = true

		if dfsCfg and not string.nilorempty(dfsCfg.eliminatorTimeLimit) then
			local times = string.split(dfsCfg.eliminatorTimeLimit, "#")

			if times and GameUtil.checkIsInTimePeriod(times[1], times[2]) then
				isDfsEnd = false
			end
		end

		if isDfsEnd then
			if buyTime > 0 and buyTime <= endTime then
				if self._baseInfo.isTopArea then
					self._activationTxt.text = "领取"
					self._taskDescTxt.text = "恭喜达标巅峰夺冠全额返条件"

					GameUtil.SetActive(self._redpointGo, true)
				else
					self._activationTxt.text = "已激活"
					self._taskDescTxt.text = "区服未能在巅峰赛中夺冠，无法领取返利"
				end
			else
				self._taskDescTxt.text = "购买活动已结束"
				self._activationTxt.text = "前往激活"
			end
		else
			self._taskDescTxt.text = "购买活动已结束"
			self._activationTxt.text = buyTime > 0 and "已激活" or "前往激活"
		end
	end

	if self._baseInfo.hasGained then
		self._activationTxt.text = "已领取"

		GameUtil.SetActive(self._redpointGo, false)
	end

	uGuiUtil.setImageGrayState(self._activationBtn.gameObject, self._baseInfo.hasGained)
end

function PeakDiamondView:_calculationSurplusTime()
	self._supTime = self._supTime - 1

	if self._supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)
		self:_updataReceiveAlreadyAward(self._baseInfo.hasGained)

		return
	end

	self:_showSurplusTimeText()
end

function PeakDiamondView:_showSurplusTimeText()
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._supTime)

	self._taskDescTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
end

function PeakDiamondView:_onClickActivationBtn()
	if self._baseInfo.hasGained then
		FloatWordMgr.instance:show("不可重复领取奖励")

		return
	end

	SurveyController.instance:reportBehavior(SurveyBehaviorID.PeakDiamondJumpTo_2)

	local endTime = GameUtil.string2time(self._actCfg.conditionTime)
	local buyTime = math.floor(checknumber(self._baseInfo.buyTime) / 1000)

	if buyTime > 0 and buyTime <= endTime and self._baseInfo.isTopArea then
		PeakReturnAgent.instance:sendPM_PeakReturnGainPrizeReq(self._actCfg.activityId)

		return
	end

	GotoMgr.gotoByString(self._actCfg.hdJumpTo)
end

return PeakDiamondView
