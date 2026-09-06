-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/QueenfansmainView.lua

module("logic.extensions.darkdragonknife.view.QueenfansmainView", package.seeall)

local QueenfansmainView = class("QueenfansmainView", ViewComponent)

function QueenfansmainView:ctor()
	QueenfansmainView.super.ctor(self)
end

function QueenfansmainView:unbindEvents()
	QueenfansmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChall)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnRule)
end

function QueenfansmainView:bindEvents()
	QueenfansmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChall, self._onClickChall, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickExchange, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnAddTime, self._buyTime, self)
end

function QueenfansmainView:buildUI()
	QueenfansmainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChall = self:getBtn("btnChall")
	self._btnExchange = self:getBtn("btnExchange")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtRemain = self:getTxt("remain/txtRemain")
	self._txtScore = self:getTxt("score/txtScore")
	self._btnAddTime = self:getBtn("remain/btnAdd")
	self._btnRule = self:getBtn("btnTip")

	local bottom = self:getGo("bottom/reward")

	self._txtGameTime = self:getTxt("bottom/txtGameTime")
	self._playerSliderMo = PlayerSliderMo.New(bottom)
end

function QueenfansmainView:onExit()
	QueenfansmainView.super.onExit(self)
	self._playerSliderMo:onExit()
	removetimer(self._timer, self)
	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeGetInfo, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeBuyTime, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeGainPrize, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeRefreshExchange, self._refresh, self)
end

function QueenfansmainView:onEnter()
	QueenfansmainView.super.onEnter(self)

	self.activityId = checknumber(DDragonKConfig.instance:getCommonCfg("NOW_ACTIVITY_ID"))

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self.activityId)

	if not isInTime then
		FloatWordMgr.instance:show("当前活动未开启")
		self:close()

		return
	end

	DDragonKModel.instance:setActId(self.activityId)

	self._actCfg = DDragonKConfig.instance:getActCfg(self.activityId)
	self._prizeCfg = DDragonKConfig.instance:getPrizeCfg(self._actCfg.prizePlan)

	DDragonKModel.instance:setPropPlanId(self._actCfg.propPlanId)
	DarkDragonKnifeAgent.instance:sendPM_DarkDragonKnifeGetInfoReq(self.activityId)
	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeGetInfo, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeBuyTime, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeGainPrize, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeRefreshExchange, self._refresh, self)

	self.startTime, self.endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DarkDragonKnife, self.activityId)

	self:_timer()
	settimer(1, self._timer, self, true)
	self:_initPlayerParams()
end

function QueenfansmainView:_timer()
	local leftTime = self.endTime - ServerTime.now()

	if leftTime > 0 then
		self._txtTime.text = string.format("剩余时间:%s", GameUtil.FormatTimeWordsNoSec(leftTime))
	else
		FloatWordMgr.instance:show("当前活动结束")
		self:close()
	end
end

function QueenfansmainView:_refresh()
	local useTime = DDragonKModel.instance:getUseTimes()
	local buyTime = DDragonKModel.instance:getBuyTimes()
	local normalTime = checknumber(DDragonKConfig.instance:getCommonCfg("DAILY_TIMES"))
	local curTimes = normalTime - useTime + buyTime

	self._txtRemain.text = langPara("次数：%s/%s", curTimes, normalTime)

	local curScore = DDragonKModel.instance:getTotalScore()

	self._txtScore.text = langPara("当前积分：%s", curScore)

	local curGameTime = DDragonKModel.instance:getGameTime()

	self:_updateGameTime(curGameTime)
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function QueenfansmainView:_updateGameTime(curGameTime)
	self._txtGameTime.text = string.format("已累计\n%ds", curGameTime)
end

function QueenfansmainView:_initPlayerParams()
	if not self._prizeCfg then
		return
	end

	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = self._prizeCfg

	function playerParam.getPlayerProgress()
		return DDragonKModel.instance:getGameTime() or 0
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.gameTime
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		local isGet = DDragonKModel.instance:getHasGainPrize(rewardCfg.id)
		local curGameTime = DDragonKModel.instance:getGameTime() or 0

		return not isGet and curGameTime >= rewardCfg.gameTime
	end

	playerParam.effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return DDragonKModel.instance:getHasGainPrize(rewardCfg.id)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		DarkDragonKnifeAgent.instance:sendPM_DarkDragonKnifeGainPrizeReq(self.activityId, rewardCfg.id)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function QueenfansmainView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "queenfansgamerule")
end

function QueenfansmainView:_onClickChall()
	local useTime = DDragonKModel.instance:getUseTimes()
	local buyTime = DDragonKModel.instance:getBuyTimes()
	local normalTime = checknumber(DDragonKConfig.instance:getCommonCfg("DAILY_TIMES"))
	local curTimes = normalTime - useTime + buyTime

	if curTimes > 0 then
		UIStateManager.instance:push(ViewName.QueenfansgameView)
	else
		FloatWordMgr.instance:show("游戏次数不足")
	end
end

function QueenfansmainView:_onClickExchange()
	UIStateManager.instance:push(ViewName.DdkExchangeView)
end

function QueenfansmainView:_buyTime()
	local buyCfg = DDragonKConfig.instance:getBuyCfg(self._actCfg.propPlanId)
	local buyCfgList = {}

	for k, v in pairs(buyCfg) do
		table.insert(buyCfgList, v)
	end

	table.sort(buyCfgList, function(a, b)
		return a.times < b.times
	end)

	local buyTime = DDragonKModel.instance:getBuyTimes()

	if buyTime < #buyCfgList then
		local price = string.split(buyCfgList[buyTime + 1].cost, ":")[3]
		local str = langPara("是否消耗%s钻石购买一次游戏次数？", price)

		TipsFacade.instance:openPopupWindow("提示", str, function()
			DarkDragonKnifeAgent.instance:sendPM_DarkDragonKnifeBuyTimesReq(self.activityId)
		end, function()
			return
		end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	else
		FloatWordMgr.instance:show("购买次数已达上限")
	end
end

return QueenfansmainView
