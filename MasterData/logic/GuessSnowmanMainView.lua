-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesssnowman/view/GuessSnowmanMainView.lua

module("logic.extensions.guesssnowman.view.GuessSnowmanMainView", package.seeall)

local GuessSnowmanMainView = class("GuessSnowmanMainView", ViewComponent)

function GuessSnowmanMainView:ctor()
	GuessSnowmanMainView.super.ctor(self)
end

function GuessSnowmanMainView:buildUI()
	GuessSnowmanMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnRule = goutil.findChild(self.mainGO, "btnRule")
	self._btnStart = goutil.findChild(self.mainGO, "btnChallenge")
	self._btnRank = goutil.findChild(self.mainGO, "btnRank")
	self._btnCard = goutil.findChild(self.mainGO, "btnCard")
	self._txtGameNum = goutil.findChildTextComponent(self.mainGO, "txtLeaves")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "playerRoot/txtTotal")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txt")
	self._playerRoot = goutil.findChild(self.mainGO, "playerRoot")
	self._rewardSliderMo = PlayerSliderMo.New(self._playerRoot)
end

function GuessSnowmanMainView:bindEvents()
	GuessSnowmanMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnCard, self._onClickMakeSnowman, self)
end

function GuessSnowmanMainView:unbindEvents()
	GuessSnowmanMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnCard)
end

function GuessSnowmanMainView:destroyUI()
	GuessSnowmanMainView.super.destroyUI(self)
end

function GuessSnowmanMainView:onEnter()
	GuessSnowmanMainView.super.onEnter(self)

	local param = self:getFirstParam()

	self._activityId = param and checknumber(param) > 0 and checknumber(param) or GuessBoxModel.instance:getCurrActId()

	if self._activityId == false then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.GuessBoxGameGetInfo, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.GuessBoxGameGainScorePrize, self._PM_GuessBoxGameGainScorePrizeRes, self)

	self._gbCfg = GuessBoxConfig.instance:getGbCfg(self._activityId)

	self:initSlider()
	GuessBoxAgent.instance:sendPM_GuessBoxGameGetInfoReq(self._activityId)

	local storyId = self._gbCfg.firstStoryId

	if storyId > 0 then
		local key = string.format("GuessSnowman_First_Story_%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end
end

function GuessSnowmanMainView:onExit()
	GuessSnowmanMainView.super.onExit(self)
	self._rewardSliderMo:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.GuessBoxGameGetInfo, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.GuessBoxGameGainScorePrize, self._PM_GuessBoxGameGainScorePrizeRes, self)
end

function GuessSnowmanMainView:_refreshView()
	self._rewardSliderMo:updatePlayerReward()

	self._txtGameNum.text = langPara("剩余游戏次数：%d/%d", self._gbCfg.dailyPlayTimes - GuessBoxModel.instance:getDailyHasPlayeTimes(), self._gbCfg.dailyPlayTimes)
	self._txtScore.text = GuessBoxModel.instance:getScore()
end

function GuessSnowmanMainView:_onClickRule()
	UIStateManager.instance:push(ViewName.GuessBoxRuleView, self._activityId)
end

function GuessSnowmanMainView:_onClickStart()
	if self._gbCfg.dailyPlayTimes > GuessBoxModel.instance:getDailyHasPlayeTimes() then
		UIStateManager.instance:push(ViewName.GuessSnowmanSelectView, self._activityId)
	else
		FloatWordMgr.instance:show(lang("今日游玩次数已达上限"))
	end
end

function GuessSnowmanMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.GuessSnowmanRankView, self._activityId)
end

function GuessSnowmanMainView:_onClickMakeSnowman()
	GotoMgr.gotoByString("func#765")
end

function GuessSnowmanMainView:initSlider()
	local sliderParam = {}

	sliderParam.view = self
	sliderParam.prizeCfgs = GuessBoxConfig.instance:getRewardProgressListCfgs(self._activityId)

	function sliderParam.getPlayerProgress()
		return GuessBoxModel.instance:getScore()
	end

	function sliderParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.score
	end

	function sliderParam.getPrizeByRewardCfg(rewardCfg)
		return rewardCfg.prize
	end

	function sliderParam.isPlayerRewardCanGet(rewardCfg)
		return GuessBoxModel.instance:isCanGetProgressReward(self._activityId, rewardCfg.prizeId)
	end

	function sliderParam.isPlayerRewardGeted(rewardCfg)
		return GuessBoxModel.instance:isGetedProgressReward(self._activityId, rewardCfg.prizeId)
	end

	function sliderParam.sendGainPlayerPrizeReq(rewardCfg)
		GuessBoxAgent.instance:sendPM_GuessBoxGameGainScorePrizeReq(self._activityId, rewardCfg.prizeId)
	end

	local isSkipAnimation = true

	self._rewardSliderMo:initParam(sliderParam, isSkipAnimation)
	self._rewardSliderMo:onEnter()
	self._rewardSliderMo:updatePlayerReward()
	self._rewardSliderMo:relocation()
end

function GuessSnowmanMainView:_PM_GuessBoxGameGainScorePrizeRes()
	GuessBoxAgent.instance:sendPM_GuessBoxGameGetInfoReq(self._activityId)
end

return GuessSnowmanMainView
