-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/generalworldprogress/view/GeneralWorldProgressView.lua

module("logic.extensions.generalworldprogress.view.GeneralWorldProgressView", package.seeall)

local GeneralWorldProgressView = class("GeneralWorldProgressView", ViewComponent)

function GeneralWorldProgressView:buildUI()
	GeneralWorldProgressView.super.buildUI(self)

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtProgress = goutil.findChildTextComponent(playerRoot, "progress/txtProgress")
	self._btnClose = self:getGo("btnClose")
	self._btnGoto = self:getGo("btnGoto")
	self._rpGoto = goutil.findChild(self._btnGoto, "redPoint")
	self._btnGainPrize = self:getGo("btnGainPrize")
	self._iconPrize = goutil.findChild(self._btnGainPrize, "icon")
	self._txtNumPrize = goutil.findChildTextComponent(self._btnGainPrize, "txtNum")
	self._timePrize = goutil.findChild(self._btnGainPrize, "time")
	self._markGainPrize = self:getGo("markGainPrize")
	self._bgChange = self:getGo("bgChange")
	self._btnTip = self:getGo("btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._txtGainPrize = self:getTxt("btnGainPrize/time/txt")
end

function GeneralWorldProgressView:bindEvents()
	GeneralWorldProgressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnGainPrize, self._onClickGainPrize, self)
end

function GeneralWorldProgressView:unbindEvents()
	GeneralWorldProgressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoto)
	GameUtil.rmClickHandler(self._btnGainPrize)
	GameUtil.rmClickHandler(self._btnTip)
end

function GeneralWorldProgressView:onEnter()
	GeneralWorldProgressView.super.onEnter(self)

	local actId = checkint(self:getFirstParam())

	if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.GeneralWorldProgress, actId) then
		GeneralWorldProgressController.instance:getInfo(actId)
		PartyController.instance:getInfo(actId)

		self._progressActCfg = GeneralWorldProgressConfig.instance:getActCfgById(actId)
		self._progressPrizeCfgs = GeneralWorldProgressConfig.instance:getprizeCfgsByPlanId(self._progressActCfg.prizePlanId)
		self._partyActCfg = PartyConfig.instance:getActsfgByActId(actId)

		local proxy = MaterialMgr.setCellByCfg(self._partyActCfg.prize, self._iconPrize)

		proxy.binder:setBgActive(false)
		proxy.binder:setNum(0)

		local matType, matId, matNum = MaterialMgr.getMatParams(self._partyActCfg.prize)

		self._txtNumPrize.text = matNum
		self._actTimeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.GeneralWorldProgress, actId)

		local startTime, endTime = self._actTimeCfg.startTime, self._actTimeCfg.endTime
		local startDate, endDate = GameUtil.string2date(startTime), GameUtil.string2date(endTime)

		self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

		self:_initPlayerParams()
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动不在时间内"), GameUtil.handler(self.close, self))
	end

	GlobalDispatcher:addListener(GlobalNotify.GeneralWorldProgressGetInfo, self._refreshProgressInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.GeneralWorldProgressGainPrize, self._refreshProgress, self)
	GlobalDispatcher:addListener(GlobalNotify.PartyPrizeGainStatusUpdate, self._refreshPrizeStatus, self)
	RedPointController.instance:regRedPoint(self._rpGoto, RedPointModel.ID_WORLD_PROGRESS_TASK)
end

function GeneralWorldProgressView:onExit()
	GeneralWorldProgressView.super.onExit(self)
	self._playerSliderMo:onExit()
	uGuiUtil.clearImage(self._bgChange)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	if self._giftEff then
		UIEffectManager.instance:stopEffect(self._giftEff)

		self._giftEff = nil
	end

	GlobalDispatcher:removeListener(GlobalNotify.GeneralWorldProgressGetInfo, self._refreshProgressInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.GeneralWorldProgressGainPrize, self._refreshProgress, self)
	GlobalDispatcher:removeListener(GlobalNotify.PartyPrizeGainStatusUpdate, self._refreshPrizeStatus, self)
	RedPointController.instance:unregRedPoint(self._rpGoto)
	MaterialMgr.resetAll(self._iconPrize)
end

function GeneralWorldProgressView:_initPlayerParams()
	if not self._progressPrizeCfgs then
		return
	end

	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = self._progressPrizeCfgs

	function playerParam.getPlayerProgress()
		return GeneralWorldProgressModel.instance:getCurProgress()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.needScore
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return rewardCfg.needScore <= GeneralWorldProgressModel.instance:getCurProgress() and not GeneralWorldProgressModel.instance:getIsGainPrize(rewardCfg.prizeId)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return GeneralWorldProgressModel.instance:getIsGainPrize(rewardCfg.prizeId)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		GeneralWorldProgressController.instance:gainPrize(self._progressActCfg.activityId, rewardCfg.prizeId)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function GeneralWorldProgressView:_refreshProgressInfo()
	self:_refreshProgress()

	local curProgress = GeneralWorldProgressModel.instance:getCurProgress()

	self._curShowCfg = nil

	for i, v in ipairs(self._progressPrizeCfgs) do
		if curProgress >= v.needScore and not string.nilorempty(v.pic) then
			self._curShowCfg = v
		end
	end

	if self._curShowCfg then
		uGuiUtil.clearImage(self._bgChange)

		local bgPath = GameUrl.getOperationSummaryBGUrl(self._curShowCfg.pic)

		uGuiUtil.setSpriteToImage(self._bgChange, uGuiUtil.SpriteType.BigBg, bgPath)

		if self._mainEff then
			UIEffectManager.instance:stopEffect(self._mainEff)

			self._mainEff = nil
		end

		local effPath = string.format("%s.prefab", self._curShowCfg.fx)

		self._mainEff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self.mainGO.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
	end
end

function GeneralWorldProgressView:_refreshProgress()
	self._txtProgress.text = GeneralWorldProgressModel.instance:getCurProgress()

	self._playerSliderMo:updatePlayerReward()
end

function GeneralWorldProgressView:_refreshPrizeStatus()
	local hasGain = PartyModel.instance:getHasGainStaus()

	goutil.setActive(self._markGainPrize, hasGain)
	goutil.setActive(self._timePrize, true)
	GameUtil.SetGray(self._iconPrize, hasGain)

	if self._giftEff then
		UIEffectManager.instance:stopEffect(self._giftEff)

		self._giftEff = nil
	end

	local startTime = GameUtil.string2date(self._partyActCfg.startTime)

	self._txtGainPrize.text = langPara("%d.%d后可领取", startTime.month, startTime.day)

	if GameUtil.getTimePeriod(self._partyActCfg.startTime, self._partyActCfg.endTime) == GameUtil.inTimePeriod and not hasGain then
		goutil.setActive(self._timeGoto, false)

		local effPath = "20230331/choubeizhounianqing/fx_ui_zhounianqi_guang.prefab"

		self._giftEff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self._btnGainPrize.transform)
			eff:setLocalPos(0, 25, 0)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
	end
end

function GeneralWorldProgressView:_onClickGoto()
	UIStateManager.instance:push(ViewName.GeneralWorldProgressTaskView, self:getFirstParam())
end

function GeneralWorldProgressView:_onClickGainPrize()
	if PartyModel.instance:getHasGainStaus() then
		FloatWordMgr.instance:show("奖励已领取")
	elseif GameUtil.getTimePeriod(self._partyActCfg.startTime, self._partyActCfg.endTime) == GameUtil.inTimePeriod then
		PartyController.instance:gainPrize(self._partyActCfg.activityId)
	else
		FloatWordMgr.instance:show("未到领取时间")
	end
end

function GeneralWorldProgressView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "General_World_Progress_Rule")
end

return GeneralWorldProgressView
