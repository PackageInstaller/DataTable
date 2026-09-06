-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/festiveflower/view/FestiveFlowerMainView.lua

module("logic.extensions.festiveflower.view.FestiveFlowerMainView", package.seeall)

local FestiveFlowerMainView = class("FestiveFlowerMainView", ViewComponent)

function FestiveFlowerMainView:ctor()
	FestiveFlowerMainView.super.ctor(self)
end

function FestiveFlowerMainView:unbindEvents()
	FestiveFlowerMainView.super.unbindEvents(self)
	ToggleValueChangedHandler.Get(self._toggle.gameObject):RemoveLuaHandler(self._toggleHandler)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnGainFlower)
	GameUtil.rmClickHandler(self._btnSendFlower)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
end

function FestiveFlowerMainView:bindEvents()
	FestiveFlowerMainView.super.bindEvents(self)

	self._toggleHandler = ToggleValueChangedHandler.Get(self._toggle.gameObject):AddLuaHandler(function(_, isOn)
		self:_onToggleChanged()
	end)

	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnGainFlower, self._onClickGainFlower, self)
	GameUtil.addClickHandler(self._btnSendFlower, self._onClickSendFlower, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function FestiveFlowerMainView:buildUI()
	FestiveFlowerMainView.super.buildUI(self)

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtPlayerScore = self:getTxt("txtPlayerScore")
	self._toggle = self:getGo("Toggle"):GetComponent("Toggle")
	self._firstRankHead = self:getGo("first/headcell")
	self._name = self:getGo("first/name")
	self._firstRankName = self:getTxt("first/name/txtName")
	self._firstRankScore = self:getTxt("first/txtScore")
	self._btnRank = self:getBtn("btnRank")
	self._btnPrize = self:getBtn("btnPrize")
	self._btnGainFlower = self:getBtn("btnGainFlower")
	self._btnSendFlower = self:getBtn("btnSendFlower")
	self._btnClose = self:getBtn("static/btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtTime = self:getTxt("time/txtTime")
	self._gainFlowerRedGo = self:getGo("btnGainFlower/redPoint")
	self._txtTip = self:getTxt("txtTip")
end

function FestiveFlowerMainView:onExit()
	FestiveFlowerMainView.super.onExit(self)

	local controller = FestiveFlowerController.instance

	controller:unregisterLocalNotify(FestiveFlowerController.E_InfoRes, self._updateAll, self)
	controller:unregisterLocalNotify(FestiveFlowerController.E_GainPrizeRes, self._updateProgressPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.SendFlowerSuc, self._reloadServerData, self)
	HeadItemController.instance:resetHeadCell(self._firstRankHead)
	RedPointController.instance:unregRedPoint(self._gainFlowerRedGo)
	self._playerSliderMo:onExit()
end

function FestiveFlowerMainView:onEnter()
	FestiveFlowerMainView.super.onEnter(self)

	local controller = FestiveFlowerController.instance
	local model = FestiveFlowerModel.instance

	controller:registerLocalNotify(FestiveFlowerController.E_InfoRes, self._updateAll, self)
	controller:registerLocalNotify(FestiveFlowerController.E_GainPrizeRes, self._updateProgressPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.SendFlowerSuc, self._reloadServerData, self)

	self._activityId = FestiveFlowerModel.instance:getActivityId()

	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.FESTIVE_FLOWER, self._activityId)

	if not activityConf or not GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		FloatWordMgr.instance:show(lang("FirePowerContestMainView__2"))
		self:close()

		return
	end

	self._txtTip.text = lang("FestiveFlowerMainView__3")

	self:_initActivityTimeText()

	self._toggle.isOn = model.ignoreFlowerAnim

	self:_initRewardSlider()
	self:_reloadServerData()
	RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_FESTIVE_FLOWER_ONCE, true)
	RedPointController.instance:regRedPoint(self._gainFlowerRedGo, 294)
end

function FestiveFlowerMainView:_reloadServerData()
	if self._activityId and self._activityId > 0 then
		FestiveFlowerAgent.instance:sendPM_FestiveFlowerInfoReq(self._activityId)
	end
end

function FestiveFlowerMainView:_initActivityTimeText()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.FESTIVE_FLOWER, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function FestiveFlowerMainView:_initRewardSlider()
	local playerParam = {}
	local model = FestiveFlowerModel.instance

	playerParam.view = self
	playerParam.prizeCfgs = FestiveFlowerConfig.instance:getPrizeConfigs(self._activityId)

	function playerParam.getPlayerProgress()
		return model.myScore
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.progress
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return model:isRewardCanGet(rewardCfg.prizeId, rewardCfg.progress)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return model:isRewardGeted(rewardCfg.prizeId)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		FestiveFlowerController.instance:reqGainPrize(rewardCfg.prizeId)
	end

	function playerParam.parseGetProgress(rewardCfg)
		return rewardCfg.progress
	end

	local isSkipAnimation = false

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function FestiveFlowerMainView:_setPlayerScore()
	local num = FestiveFlowerModel.instance.myScore

	self._txtPlayerScore.text = string.format("%d", num)
end

function FestiveFlowerMainView:_updateAll()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
	self:_setPlayerScore()
	self:_setFirstRank()
end

function FestiveFlowerMainView:_updateProgressPrizeRes()
	self._playerSliderMo:updatePlayerReward()
	self:_setPlayerScore()
end

function FestiveFlowerMainView:_setFirstRank()
	local model = FestiveFlowerModel.instance
	local rankFirst = model.rankFirst

	HeadItemController.instance:resetHeadCell(self._firstRankHead)

	if rankFirst then
		local proxy = HeadItemController.instance:setHeadCellByInfo(self._firstRankHead, rankFirst.headInfo)

		if proxy then
			proxy:setCallBack(function()
				if rankFirst.headInfo.userId then
					FriendController.instance:showInfoView(rankFirst.headInfo.userId, self._firstRankHead)
				end
			end)
		end

		self._firstRankName.text = string.format("%s\n%s", rankFirst.headInfo.areaName, rankFirst.headInfo.userName)
		self._firstRankScore.text = tostring(rankFirst.score or 0)

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._name:GetComponent(goutil.Type_RectTransform))
	else
		self._firstRankName.text = lang("虚位以待")
		self._firstRankScore.text = ""
	end

	GameUtil.SetActive(self._name, rankFirst)
end

function FestiveFlowerMainView:_onToggleChanged()
	FestiveFlowerController.instance:setIgnoreFlowerAnim(self._toggle.isOn)
end

function FestiveFlowerMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.FestiveFlowerRankView)
end

function FestiveFlowerMainView:_onClickPrize()
	UIStateManager.instance:push(ViewName.FestiveFlowerRankPrizeView)
end

function FestiveFlowerMainView:_onClickGainFlower()
	UIStateManager.instance:push(ViewName.FestiveFlowerGainView)
end

local RememberSendKey = "FestiveFlowerMainView_RememberSendKey"

function FestiveFlowerMainView:_onClickSendFlower()
	local function doIt()
		FriendController.instance:OpenFriendView()
	end

	if not GameUtil.getUserDayData(RememberSendKey) then
		local function funcTog()
			GameUtil.saveUserDayData(RememberSendKey, true)
		end

		local togText = lang("FestiveFlowerMainView__1")

		TipsFacade.instance:openPopupWindowWithTog(lang("tip"), lang("FestiveFlowerMainView__2"), doIt, nil, funcTog, nil, nil, togText)
	else
		doIt()
	end
end

function FestiveFlowerMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "festiveflower_rule")
end

function FestiveFlowerMainView:_onClickClose()
	self:close()
end

return FestiveFlowerMainView
