-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/view/NewGuessLanternMainView.lua

module("logic.extensions.guesslantern.view.NewGuessLanternMainView", package.seeall)

local NewGuessLanternMainView = class("NewGuessLanternMainView", ViewComponent)

function NewGuessLanternMainView:buildUI()
	NewGuessLanternMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")

	local rewardRoot = self:getGo("rewardRoot")

	self._playerSliderMo = PlayerSliderMo.New(rewardRoot)
	self._txtPlayerScore = self:getTxt("total/txtTotal")
	self._txtTime = self:getTxt("time/txt")
	self._root = self:getGo("guessLanterns")
	self._goBase = self:getGo("base")
end

function NewGuessLanternMainView:bindEvents()
	NewGuessLanternMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function NewGuessLanternMainView:unbindEvents()
	NewGuessLanternMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()

	for i, v in ipairs(self._guessList) do
		v.btn:RemoveClickListener()
	end
end

function NewGuessLanternMainView:onEnter()
	NewGuessLanternMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GuessLanternGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GuessLanternGainPrizeRes, self._onGainPrizeRes, self)
	self:_initDefaultView()

	self._activityId = checkint(self:getFirstParam()) or GuessLanternModel.instance:getActivityId()
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
	self._problemCfg = GuessLanternConfig.instance:getProblemCfgList(self._problemPlanId)
	self._isAllPass = false

	self:_initActivityTime()
	self:_initRewardParams()
	self:_setPlayerScore()
	self:_initGuessList()
	self:_updateGuessList()
	GuessLanternAgent.instance:sendPM_GuessLanternGetInfoReq(self._activityId)
end

function NewGuessLanternMainView:onExit()
	NewGuessLanternMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GuessLanternGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GuessLanternGainPrizeRes, self._onGainPrizeRes, self)
	self._playerSliderMo:onExit()
	self:_clearEffects()

	for i, v in ipairs(self._guessList) do
		v.btn:RemoveClickListener()
	end

	self:_clearGuessList()
end

function NewGuessLanternMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "NewGuessLanternMainView_rule")
end

function NewGuessLanternMainView:_onClickBtn(index)
	local isGuessed, problemId = GuessLanternModel.instance:isGuessedByIndex(index)

	if isGuessed or self._isAllPass then
		FloatWordMgr.instance:show("所有题目均已答完~")
	else
		local imgChName = self:getOpenParam()[2]

		UIStateManager.instance:push(ViewName.NewGuessLanternAnswerView, self._activityId, problemId, imgChName)
	end
end

function NewGuessLanternMainView:_onGetInfoRes()
	print("=======> 获取信息成功")

	local guessNum = GuessLanternModel.instance:getRewardProgress()

	self._isAllPass = guessNum >= #self._problemCfg

	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
	self:_setPlayerScore()
	self:_updateGuessList()
end

function NewGuessLanternMainView:_onGainPrizeRes()
	print("=======> 玩家已领取奖励")
	GuessLanternAgent.instance:sendPM_GuessLanternGetInfoReq(self._activityId)
end

function NewGuessLanternMainView:_initRewardParams()
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

function NewGuessLanternMainView:_setPlayerScore()
	self._txtPlayerScore.text = GuessLanternModel.instance:getRewardProgress()
end

function NewGuessLanternMainView:_initActivityTime()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function NewGuessLanternMainView:_initGuessList()
	self._guessList = {}

	local itemRectTrans = self._goBase:GetComponent(goutil.Type_RectTransform)
	local problemNum = self._cfgActivity.problemNum
	local itemWidth = goutil.getWidth(itemRectTrans)
	local spacing = 15
	local delta = 30
	local midIndex = math.floor(problemNum / 2) + 1

	for i = 1, problemNum do
		local posX, posY = 0, 0

		posX = problemNum % 2 == 0 and (i - midIndex + 0.5) * (itemWidth + spacing) or (i - midIndex) * (itemWidth + spacing)
		posY = i % 2 == 0 and delta or -1 * delta

		local go = goutil.cloneAndSetParent(self._goBase, self._root.transform, "guessLantern_" .. i)

		GameUtil.setLocalPos(go.transform, posX, posY, 0)

		local element = {}

		element.btn = Framework.ButtonAdapter.Get(go)
		element.bgState = goutil.findChild(go, "bg"):GetComponent("UIImageSpriteChange")
		element.imgState = goutil.findChild(go, "state"):GetComponent("UIImageSpriteChange")
		element.effect = goutil.findChild(go, "effect")

		element.btn:AddClickListener(function()
			self:_onClickBtn(i)
		end)
		goutil.setActive(go, true)
		table.insert(self._guessList, element)
	end
end

function NewGuessLanternMainView:_updateGuessList()
	for i, v in ipairs(self._guessList) do
		local isGuessed, problemId = GuessLanternModel.instance:isGuessedByIndex(i)

		v.bgState:SetState((isGuessed or self._isAllPass) and 1 or 0)
		v.imgState:SetState((isGuessed or self._isAllPass) and 2 or 0)
		goutil.setActive(v.effect, isGuessed)

		if isGuessed or self._isAllPass then
			self:_loadEffect(i, v.effect)
		else
			self:_removeEffect(i)
		end
	end
end

function NewGuessLanternMainView:_clearGuessList()
	goutil.clearChildren(self._root)
end

function NewGuessLanternMainView:_initDefaultView()
	self._txtPlayerScore.text = "0"

	self:_initEffects()
end

function NewGuessLanternMainView:_initEffects()
	self:_clearEffects()

	self._effectList = {}
	self._bgEffect = UIEffectManager.instance:playEffect(self, NewGuessLanternMainViewPresentor.Effect1, self.mainGO.transform, 0, 0, true, false)

	self._bgEffect:setParent(self.mainGO.transform)
	self._bgEffect:setScale(1)
	self._bgEffect:setLocalPos(0, 0, 0)
end

function NewGuessLanternMainView:_clearEffects()
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

function NewGuessLanternMainView:_loadEffect(i, go)
	self:_removeEffect(i)

	local effect = UIEffectManager.instance:playEffect(self, NewGuessLanternMainViewPresentor.Effect2, go.transform, 0, 0, true, false)

	effect:setParent(go.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	self._effectList[i] = effect
end

function NewGuessLanternMainView:_removeEffect(i)
	if self._effectList[i] then
		UIEffectManager.instance:stopEffect(self._effectList[i])

		self._effectList[i] = nil
	end
end

return NewGuessLanternMainView
