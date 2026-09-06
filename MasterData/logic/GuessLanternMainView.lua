-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/view/GuessLanternMainView.lua

module("logic.extensions.guesslantern.view.GuessLanternMainView", package.seeall)

local GuessLanternMainView = class("GuessLanternMainView", ViewComponent)

function GuessLanternMainView:buildUI()
	GuessLanternMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")

	local rewardRoot = self:getGo("rewardRoot")

	self._playerSliderMo = PlayerSliderMo.New(rewardRoot)
	self._txtPlayerScore = self:getTxt("total/txtTotal")
	self._txtTime = self:getTxt("time/txt")
	self._guessList = {}

	local guessLanterns = self:getGo("guessLanterns")

	for i = 1, 5 do
		local go = goutil.findChild(guessLanterns, "btn" .. i)
		local element = {}

		element.btn = Framework.ButtonAdapter.Get(go)
		element.txt = goutil.findChildTextComponent(go, "txt")
		element.img1 = goutil.findChild(go, "img1")
		element.img2 = goutil.findChild(go, "img2")
		element.effect = goutil.findChild(go, "effect")

		table.insert(self._guessList, element)
	end
end

function GuessLanternMainView:bindEvents()
	GuessLanternMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)

	for i, v in ipairs(self._guessList) do
		v.btn:AddClickListener(function()
			self:_onClickBtn(i)
		end)
	end
end

function GuessLanternMainView:unbindEvents()
	GuessLanternMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()

	for i, v in ipairs(self._guessList) do
		v.btn:RemoveClickListener()
	end
end

function GuessLanternMainView:onEnter()
	GuessLanternMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GuessLanternGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GuessLanternGainPrizeRes, self._onGainPrizeRes, self)
	self:_initDefaultView()

	self._activityId = GuessLanternModel.instance:getActivityId()
	self._activityType = GuessLanternModel.instance:getActivityType()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = GuessLanternConfig.instance:getActivityCfg(self._activityId)
	self._problemPlanId = self._cfgActivity.problemPlanId

	self:_initActivityTime()
	self:_initRewardParams()
	self:_setPlayerScore()
	self:_updateGuessList()
	GuessLanternAgent.instance:sendPM_GuessLanternGetInfoReq(self._activityId)
end

function GuessLanternMainView:onExit()
	GuessLanternMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GuessLanternGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GuessLanternGainPrizeRes, self._onGainPrizeRes, self)
	self._playerSliderMo:onExit()
	self:_clearEffects()
end

function GuessLanternMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "guesslanternmainview_rule")
end

function GuessLanternMainView:_onClickBtn(index)
	local isGuessed, problemId = GuessLanternModel.instance:isGuessedByIndex(index)

	if isGuessed then
		FloatWordMgr.instance:show("今日灯谜已猜完，明天再来吧~")
	else
		UIStateManager.instance:push(ViewName.GuessLanternAnswerView, self._activityId, problemId)
	end
end

function GuessLanternMainView:_onGetInfoRes()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
	self:_setPlayerScore()
	self:_updateGuessList()
end

function GuessLanternMainView:_onGainPrizeRes()
	self._playerSliderMo:updatePlayerReward()
	self:_setPlayerScore()
end

function GuessLanternMainView:_initRewardParams()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = GuessLanternConfig.instance:getPrizeCfgList(self._activityId)

	function playerParam.getPlayerProgress()
		return GuessLanternModel.instance:getRewardProgress()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.progress
	end

	function playerParam.getPrizeByRewardCfg(rewardCfg)
		local prizes = string.split(rewardCfg.prize, "#")

		return prizes[1]
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return GuessLanternModel.instance:isPlayerRewardCanGet(rewardCfg.prizeId, rewardCfg.progress)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return GuessLanternModel.instance:isPlayerRewardGeted(rewardCfg.prizeId)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		GuessLanternAgent.instance:sendPM_GuessLanternGainPrizeReq(self._activityId, rewardCfg.prizeId)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function GuessLanternMainView:_setPlayerScore()
	self._txtPlayerScore.text = GuessLanternModel.instance:getRewardProgress()
end

function GuessLanternMainView:_initActivityTime()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function GuessLanternMainView:_updateGuessList()
	for i, v in ipairs(self._guessList) do
		local isGuessed, problemId = GuessLanternModel.instance:isGuessedByIndex(i)

		v.txt.text = isGuessed and "已\n猜\n完" or "未\n猜\n出"

		goutil.setActive(v.img1, not isGuessed)
		goutil.setActive(v.img2, isGuessed)
		goutil.setActive(v.effect, isGuessed)

		if isGuessed then
			self:_loadEffect(i, v.effect)
		else
			self:_removeEffect(i)
		end
	end
end

function GuessLanternMainView:_initDefaultView()
	self._txtPlayerScore.text = "0"

	self:_initEffects()
end

function GuessLanternMainView:_initEffects()
	self:_clearEffects()

	self._effectList = {}
	self._bgEffect = UIEffectManager.instance:playEffect(self, GuessLanternMainViewPresentor.Effect1, self.mainGO.transform, 0, 0, true, false)

	self._bgEffect:setParent(self.mainGO.transform)
	self._bgEffect:setScale(1)
	self._bgEffect:setLocalPos(0, 0, 0)
end

function GuessLanternMainView:_clearEffects()
	if self._effectList then
		for i, v in pairs(self._effectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._effectList = nil
	end

	if self._bgEffect then
		UIEffectManager.instance:stopEffect(self._bgEffect)

		self._bgEffect = nil
	end
end

function GuessLanternMainView:_loadEffect(i, go)
	self:_removeEffect(i)

	local effect = UIEffectManager.instance:playEffect(self, GuessLanternMainViewPresentor.Effect2, go.transform, 0, 0, true, false)

	effect:setParent(go.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	self._effectList[i] = effect
end

function GuessLanternMainView:_removeEffect(i)
	if self._effectList[i] then
		UIEffectManager.instance:stopEffect(self._effectList[i])

		self._effectList[i] = nil
	end
end

return GuessLanternMainView
