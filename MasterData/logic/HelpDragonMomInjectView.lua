-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/view/HelpDragonMomInjectView.lua

module("logic.extensions.helpdragonmom.view.HelpDragonMomInjectView", package.seeall)

local HelpDragonMomInjectView = class("HelpDragonMomInjectView", ViewComponent)
local FinishTimestamp = 1656018000

function HelpDragonMomInjectView:ctor()
	HelpDragonMomInjectView.super.ctor(self)
end

function HelpDragonMomInjectView:buildUI()
	HelpDragonMomInjectView.super.buildUI(self)

	local worldRoot = self:getGo("worldRoot")
	local playerRoot = self:getGo("playerRoot")

	self._worldSliderMo = WorldSliderMo.New(worldRoot)
	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtPlayerScore = self:getTxt("txtPlayerScore")
	self._sliderMask = self:getGo("playerslidermask")
	self._btnStory = self:getBtn("btnStory")
	self._btnInject = self:getBtn("btnInject")
	self._btnGo = self:getBtn("btnGo")
	self._btnGoRedpoint = self:getGo("btnGo/redPoint")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtCostNum = self:getTxt("btnInject/txt2")
	self._imgCostItem = self:getGo("btnInject/icon")
	self._tipsGo = self:getGo("tips")

	goutil.setActive(self._tipsGo, false)

	MaterialMgr.findGraphicText(self.mainGO, "rewardTip/txtItems").text = "<quad name=4:112:30 size=80 width=1 offsetY=-5/> <quad name=4:36:20 size=80 width=1 offsetY=-5/> <quad name=4:90212:2 size=80 width=1 offsetY=-5/> <quad name=4:70021:1 size=80 width=1 offsetY=-5/>"
end

function HelpDragonMomInjectView:bindEvents()
	HelpDragonMomInjectView.super.bindEvents(self)
	self._btnStory:AddClickListener(self._onClickStory, self)
	self._btnInject:AddClickListener(self._onClickInject, self)
	self._btnGo:AddClickListener(self._onClickGo, self)
	self._worldSliderMo:bindEvents()
end

function HelpDragonMomInjectView:unbindEvents()
	HelpDragonMomInjectView.super.unbindEvents(self)
	self._btnStory:RemoveClickListener()
	self._btnInject:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	self._worldSliderMo:unbindEvents()
end

function HelpDragonMomInjectView:onEnter()
	HelpDragonMomInjectView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HelpDragonMomGetInfoRes, self._onHelpDragonMomGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HelpDragonMomWorldAwardRes, self._onHelpDragonMomWorldAwardRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HelpDragonMomChallengeRes, self._onHelpDragonMomChallengeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HelpDragonMomSelfAwardRes, self._onHelpDragonMomSelfAwardRes, self)

	self._activityId = HelpDragonMomModel.instance:getActivityId()
	self._worldRewardPlanId = HelpDragonMomModel.instance:getWorldRewardPlanId()
	self._playerRewardPlanId = HelpDragonMomModel.instance:getPlayerRewardPlanId()

	self:_playOnceStoryOnEnter()
	self:_initTipState()
	self:_initWorldParams()
	self:_initPlayerParams()
	self:_setPlayerScore()

	self._activityCfg = HelpDragonMomConfig.instance:getActivityCfg(self._activityId)

	self:_setGoldBar(self._activityCfg.costItem)
	self:_setCostItem(self._activityCfg.costItem)
	RedPointController.instance:regRedPoint(self._btnGoRedpoint, 279)
end

function HelpDragonMomInjectView:onExit()
	HelpDragonMomInjectView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HelpDragonMomGetInfoRes, self._onHelpDragonMomGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.HelpDragonMomWorldAwardRes, self._onHelpDragonMomWorldAwardRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.HelpDragonMomChallengeRes, self._onHelpDragonMomChallengeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.HelpDragonMomSelfAwardRes, self._onHelpDragonMomSelfAwardRes, self)
	self._worldSliderMo:onExit()
	self._playerSliderMo:onExit()
	self:_clearCostItem()
	RedPointController.instance:unregRedPoint(self._btnGoRedpoint)
end

function HelpDragonMomInjectView:_onClickStory()
	local storyId = OperationSummaryConfig.instance:getStoryIdByActivityId(HelpDragonMomModel.instance:getTaskActivityId())

	if storyId > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
	end
end

function HelpDragonMomInjectView:_playOnceStoryOnEnter()
	local storyId = OperationSummaryConfig.instance:getStoryIdByActivityId(HelpDragonMomModel.instance:getTaskActivityId())

	if storyId <= 0 then
		return
	end

	local isFinish = GameUtil.getUserData(ViewName.HelpDragonMomGameView .. "story" .. storyId)

	if isFinish then
		return
	end

	GameUtil.saveUserData(ViewName.HelpDragonMomGameView .. "story" .. storyId, true)
	GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
end

function HelpDragonMomInjectView:_onClickInject()
	local curTimestamp = ServerTime.now()
	local isInTime = curTimestamp <= FinishTimestamp
	local isEnough = MaterialMgr.getMatEnough(self._activityCfg.costItem)

	if not isInTime then
		FloatWordMgr.instance:show("活动结束，已无法注入能量")
	elseif not isEnough then
		FloatWordMgr.instance:show(string.format("[%s]不足，请先到其余玩法中获取哦", MaterialMgr.getMaterialsNameByCfg(self._activityCfg.costItem)))
	else
		UIStateManager.instance:push(ViewName.HelpDragonMomGameView)
	end
end

function HelpDragonMomInjectView:_onClickGo()
	FuncOpenController.instance:openFunc(FuncConst.RememberTheater)
end

function HelpDragonMomInjectView:_onHelpDragonMomGetInfoRes()
	self._worldSliderMo:updateWorldReward()
	self._playerSliderMo:updatePlayerReward()
	self:_setPlayerScore()
	self._worldSliderMo:relocation()
	self._playerSliderMo:relocation()
end

function HelpDragonMomInjectView:_onHelpDragonMomWorldAwardRes()
	self._worldSliderMo:updateWorldReward()
end

function HelpDragonMomInjectView:_onHelpDragonMomChallengeRes()
	self._playerSliderMo:updatePlayerReward()
	self:_setPlayerScore()
end

function HelpDragonMomInjectView:_onHelpDragonMomSelfAwardRes()
	self._playerSliderMo:updatePlayerReward()
	self:_setPlayerScore()
end

function HelpDragonMomInjectView:_initWorldParams()
	local worldParam = {}

	worldParam.view = self
	worldParam.prizeCfgs = HelpDragonMomConfig.instance:getRewardWorldCfgList(self._worldRewardPlanId)

	function worldParam.getWorldProgress()
		return HelpDragonMomModel.instance:getWorldProgress()
	end

	function worldParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.progress
	end

	function worldParam.isWorldRewardCanGet(rewardCfg)
		return HelpDragonMomModel.instance:isWorldRewardCanGet(rewardCfg.id, rewardCfg.progress)
	end

	function worldParam.isWorldRewardGeted(rewardCfg)
		return HelpDragonMomModel.instance:isWorldRewardGeted(rewardCfg.id)
	end

	function worldParam.isAnyWorldRewardCanGet()
		return HelpDragonMomModel.instance:isAnyWorldRewardCanGet()
	end

	function worldParam.sendGainWorldPrizeReq(rewardCfg)
		HelpDragonMomAgent.instance:sendPM_HelpDragonMomWorldAwardReq(self._activityId, rewardCfg.id)
	end

	self._worldSliderMo:initParam(worldParam)
	self._worldSliderMo:onEnter()
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
end

function HelpDragonMomInjectView:_initPlayerParams()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = HelpDragonMomConfig.instance:getRewardPlayerCfgList(self._playerRewardPlanId)

	function playerParam.getPlayerProgress()
		return HelpDragonMomModel.instance:getPlayerProgress()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.progress
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return HelpDragonMomModel.instance:isPlayerRewardCanGet(rewardCfg.id, rewardCfg.progress)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return HelpDragonMomModel.instance:isPlayerRewardGeted(rewardCfg.id)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		HelpDragonMomAgent.instance:sendPM_HelpDragonMomSelfAwardReq(self._activityId, rewardCfg.id)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function HelpDragonMomInjectView:_setPlayerScore()
	self._txtPlayerScore.text = HelpDragonMomModel.instance:getPlayerProgress()
end

function HelpDragonMomInjectView:_setGoldBar(coinStr)
	local matMo = string.splitToNumber(coinStr, ":")
	local name = matMo[1] .. ":" .. matMo[2]
	local objList = {
		{
			showAdd = true,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function HelpDragonMomInjectView:_setCostItem(coinStr)
	local matType, id, matNum = MaterialMgr.getMatParams(coinStr)

	MaterialMgr.setIcon(self._imgCostItem, matType, id)

	self._txtCostNum.text = matNum
end

function HelpDragonMomInjectView:_clearCostItem()
	MaterialMgr.clearIcon(self._imgCostItem)
end

function HelpDragonMomInjectView:_initTipState()
	local isInTime = ServerTime.now() <= FinishTimestamp

	goutil.setActive(self._tipsGo, not isInTime)
end

return HelpDragonMomInjectView
