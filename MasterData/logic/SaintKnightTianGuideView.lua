-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/view/SaintKnightTianGuideView.lua

module("logic.extensions.saintknighttian.view.SaintKnightTianGuideView", package.seeall)

local SaintKnightTianGuideView = class("SaintKnightTianGuideView", ViewComponent)

function SaintKnightTianGuideView:buildUI()
	SaintKnightTianGuideView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTimes = self:getTxt("guideBg/txtTimes")
	self._btnStart = self:getGo("guideBg/btnStart")

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._itemAmout = goutil.findChild(playerRoot, "itemAmout")
	self._txtAmout = goutil.findChildTextComponent(playerRoot, "txtAmout")
end

function SaintKnightTianGuideView:bindEvents()
	SaintKnightTianGuideView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickGame, self)
end

function SaintKnightTianGuideView:unbindEvents()
	SaintKnightTianGuideView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
end

function SaintKnightTianGuideView:onEnter()
	SaintKnightTianGuideView.super.onEnter(self)
	self:setViewByCfg()
	self:refreshViewByInfo()
	SaintKnightTianModel.instance:ShowCI()
	SaintKnightTianController.instance:getInfo(self._challengeId)
	GlobalDispatcher:addListener(GlobalNotify.SKTianUpdateInfo, self.refreshViewByInfo, self)
	SaintKnightTianModel.instance:setDailyOpen(ViewName.SaintKnightTianGuideView)
end

function SaintKnightTianGuideView:onExit()
	SaintKnightTianGuideView.super.onExit(self)
	self._playerSliderMo:onExit()
	MaterialMgr.resetAll(self._itemAmout)
	GlobalDispatcher:removeListener(GlobalNotify.SKTianUpdateInfo, self.refreshViewByInfo, self)
end

function SaintKnightTianGuideView:setViewByCfg()
	self._challengeId = SaintKnightTianModel.instance:getCurChallengeId()
	self._actCfg = SaintKnightTianConfig.instance:getActCfg(self._challengeId)

	MaterialMgr.setCellByCfg(self._actCfg.gameItemId, self._itemAmout)
	self:_initPlayerParams()
end

function SaintKnightTianGuideView:refreshViewByInfo()
	local hasUseTime = SaintKnightTianModel.instance:getUseGameTimes()

	self._txtTimes.text = langPara("今日剩余<color=#e99a02>%s</color>次", math.max(0, self._actCfg.dailyTimes - hasUseTime))

	GameUtil.SetGray(self._btnStart, hasUseTime >= self._actCfg.dailyTimes)
	self._playerSliderMo:updatePlayerReward()

	self._txtAmout.text = MaterialMgr.getMatCount(self._actCfg.gameItemId)
end

function SaintKnightTianGuideView:_initPlayerParams()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = SaintKnightTianConfig.instance:getGamePrizeCfgs(self._actCfg.gamePrizePlanId)

	function playerParam.getPlayerProgress()
		return MaterialMgr.getMatCount(self._actCfg.gameItemId)
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.needScore
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return rewardCfg.needScore <= MaterialMgr.getMatCount(self._actCfg.gameItemId) and not SaintKnightTianModel.instance:isPlayerGameRewardGeted(rewardCfg.id)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return SaintKnightTianModel.instance:isPlayerGameRewardGeted(rewardCfg.id)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		SaintKnightTianController.instance:getGamePrize(self._challengeId, rewardCfg.id)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function SaintKnightTianGuideView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "saintknighttian1_rule")
end

function SaintKnightTianGuideView:_onClickGame()
	local hasUseTime = SaintKnightTianModel.instance:getUseGameTimes()

	if hasUseTime < self._actCfg.dailyTimes then
		ViewAutoShowController.instance:saveCurModalView()
		UIStateManager.instance:push(ViewName.SKTgameView)
	else
		FloatWordMgr.instance:show(lang("今日没有游戏次数了。"))
	end
end

return SaintKnightTianGuideView
