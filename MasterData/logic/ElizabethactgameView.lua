-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elizabethgame/view/ElizabethactgameView.lua

module("logic.extensions.elizabethgame.view.ElizabethactgameView", package.seeall)

local ElizabethactgameView = class("ElizabethactgameView", ViewComponent)
local Time = UnityEngine.Time

function ElizabethactgameView:unbindEvents()
	ElizabethactgameView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnAddTimes:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnResume:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function ElizabethactgameView:bindEvents()
	ElizabethactgameView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnAddTimes:AddClickListener(self._onClickAddTimes, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnResume:AddClickListener(self._onClickResume, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
end

function ElizabethactgameView:onExit()
	ElizabethactgameView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_clearAoqiLihui()
	self._gameBall1:onExit()
	self._gameBall2:onExit()

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	if self._endEffectHandler then
		UIEffectManager.instance:stopEffect(self._endEffectHandler)

		self._endEffectHandler = nil
	end
end

function ElizabethactgameView:buildUI()
	ElizabethactgameView.super.buildUI(self)

	self._closeButton = self:getBtn("leftTop/btnClose")
	self._btnRule = self:getBtn("leftTop/btnRule")
	self._txtRule = self:getTxt("rule/txtRule")
	self._txtRemaingTime = self:getGo("countdown/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._countdown = self:getGo("countdown")
	self._btnStart = self:getBtn("btnStart")
	self._txtClick = self:getTxt("btnClick/Text")
	self._btnAddTimes = self:getBtn("remaining/btnAdd")
	self._txtRemainingTimes = self:getTxt("remaining/txtCount")
	self._btnResume = self:getBtn("btnResume")
	self._txtRule.text = lang("elizabeth_game_tip")
	self._model = self:getGo("model")
	self._ball1 = self:getGo("ball1")
	self._gameBall1 = GameUtil.AddLuaOnce(self._ball1, ElizabethactgameBall)

	self._gameBall1:setView(self)

	self._ball2 = self:getGo("ball2")
	self._gameBall2 = GameUtil.AddLuaOnce(self._ball2, ElizabethactgameBall)

	self._gameBall2:setView(self)

	self._leftTopGo = self:getGo("leftTop")
	self._redpointGo = self:getGo("btnStart/redpoint")
end

function ElizabethactgameView:onEnter()
	ElizabethactgameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ElizabethGameBuyTimesRes, self._onBuyTimesRes, self)
	self.addGEvent(self, GlobalNotify.ElizabethGameReliveRes, self._onReliveRes, self)
	self.addGEvent(self, GlobalNotify.ElizabethGameEndGameRes, self._onEndGameRes, self)
	self.addGEvent(self, GlobalNotify.ElizabethGameStartGameRes, self._onStartGameRes, self)
	self.addGEvent(self, GlobalNotify.ElizabethGameBallBoomAniDone, self._onElizabethGameBallBoomAniDone, self)
	self.addGEvent(self, GlobalNotify.ElizabethGameBallBoom, self._onBallBoomed, self)

	self._bloomedAniDone = false
	self._bloomed = false
	self._subInterval = 0.02
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.ElizabethGame)
	self._actCfg = ElizabethgameConfig.instance:getActCfg(self._activityId)
	self._maxGameTime = self._actCfg.gameTime
	self._onceGainMaxNum = self._actCfg.onceGainMaxNum

	self._gameBall1:onEnter(self, self._actCfg)
	self._gameBall2:onEnter(self, self._actCfg)
	self:_initGame()
	self:_playViewEffect()
end

function ElizabethactgameView:_createAoqiLihui()
	local effect_path = "fx_ui_yilishabaitiaozhan/aoqicuiqiqiu_spine/aoqicuiqiqiu-ui_p.prefab"

	self._aoqiEffect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, -363, 0)

		self._graphic = goutil.findChild(eff.effGo, "skeleton"):GetComponent("SkeletonGraphic")
		self._graphic.startingAnimation = "idle"

		self._graphic.AnimationState:SetAnimation(0, "idle", true)
		self._graphic:Update(0)
	end)

	self._aoqiEffect:setParent(self._model.transform)
	self._aoqiEffect:setScale(0.7)
end

function ElizabethactgameView:_clearAoqiLihui()
	if self._aoqiEffect then
		UIEffectManager.instance:stopEffect(self._aoqiEffect)

		self._aoqiEffect = nil
	end
end

function ElizabethactgameView:_updateAoqiLihuiState(_state, _loop)
	if not _state or not self._graphic then
		return
	end

	self._graphic.AnimationState:SetAnimation(0, _state, _loop)
	self._graphic:Update(0)
end

function ElizabethactgameView:_onBuyTimesRes()
	self:_updateTimes()
end

function ElizabethactgameView:_onClickResume()
	self:_startGame()
end

function ElizabethactgameView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "elizabethactmainview")
end

function ElizabethactgameView:_onClickClose()
	ViewMgr.instance:close(ViewName.ElizabethpopuptipsView)
	self:close()
end

function ElizabethactgameView:_onClickStart()
	local cur, total = ElizabethgameController.instance:getCurAndTotalTimes(self._activityId)

	if cur <= 0 then
		FloatWordMgr.instance:show("今日次数用完，次日5点重置！ ")
	else
		ElizabethgameController.instance:sendStartGameReq(self._activityId)
	end
end

function ElizabethactgameView:_onStartGameRes()
	FloatWordMgr.instance:show("游戏开始，请快速点击按钮吹起泡泡")
	self:_updateTimes()
	self:_startGame()
end

function ElizabethactgameView:_onTicking()
	local deltaTime = Time.deltaTime

	self._remainingTime = self._remainingTime - deltaTime

	if self._remainingTime < 0 then
		self._remainingTime = 0
	end

	self._txtRemaingTime:SetText(math.ceil(self._remainingTime))

	if self._remainingTime == 0 then
		self:_endGame()
	end
end

function ElizabethactgameView:_initGame()
	self._isGaming = false

	self:_updateBtnClick()
	self:_updateTimes()

	self._remainingTime = self._maxGameTime

	self._txtRemaingTime:SetText(math.ceil(self._remainingTime))
	self._gameBall1:_updateBallSize(true)
	self._gameBall2:_updateBallSize(true)
end

function ElizabethactgameView:_startGame()
	self._isGaming = true

	self._gameBall1:startGame()
	self._gameBall2:startGame()
	self:_updateBtnClick()
	settimer(0, self._onTicking, self, true)
	UIStateManager.instance:open(ViewName.ElizabethpopuptipsView)
	self:_updateAoqiLihuiState("cuiqi", true)
end

function ElizabethactgameView:_onReliveRes()
	FloatWordMgr.instance:show("复活成功")
	self._gameBall1:relive()
	self._gameBall2:relive()
	self._btnResume.gameObject:SetActive(true)
end

function ElizabethactgameView:_endGame()
	if self._gameBall1:isBloom() or self._gameBall2:isBloom() then
		return
	end

	self:_updateBtnClick()
	removetimer(self._onTicking, self)

	local volume = self._gameBall1:getCurVolume() + self._gameBall2:getCurVolume()
	local scalePrizePlanId = self._actCfg.scalePrizePlanId
	local addFlowerPerClick = self._actCfg.clickNums
	local cfgs = ElizabethgameConfig.instance:getScalePrizeCfgs(scalePrizePlanId)
	local clicks = self._gameBall1:getClicks() + self._gameBall2:getClicks()
	local flowerNums = addFlowerPerClick * clicks

	for _, v in ipairs(cfgs) do
		if volume >= v.scale then
			flowerNums = flowerNums + v.flowerNum
		end
	end

	local title = "游戏结束"

	if flowerNums > self._onceGainMaxNum then
		flowerNums = self._onceGainMaxNum
	end

	local text = string.format("本次吹气，你一共获得了\n积分x<color=#eb4642>%d</color>", flowerNums)
	local btnText = "知道了"

	TipsFacade.instance:openTipWindowNoX(title, text, function()
		ElizabethgameController.instance:sendEndGameReq(self._activityId, clicks, volume)
	end, btnText)
	self:_updateAoqiLihuiState("idle", true)
end

function ElizabethactgameView:_onEndGameRes()
	FloatWordMgr.instance:show("游戏结束~")

	self._isGaming = false

	self._gameBall1:endGame()
	self._gameBall2:endGame()
	self:_initGame()
	self:_playEndEffect()
end

function ElizabethactgameView:_updateBtnClick()
	self._btnStart.gameObject:SetActive(not self._isGaming)
	self._gameBall1:_updateBtnClick()
	self._gameBall2:_updateBtnClick()
	self._countdown:SetActive(self._isGaming)
	self._btnResume.gameObject:SetActive(false)
	goutil.setActive(self._leftTopGo, not self._isGaming)
end

function ElizabethactgameView:_updateTimes()
	local cur, total = ElizabethgameController.instance:getCurAndTotalTimes(self._activityId)

	self._txtRemainingTimes.text = string.format("今日剩余次数：%d/%d", cur, total)

	self._btnAddTimes.gameObject:SetActive(false)

	local remainingBuyTimes = ElizabethgameController.instance:getRemaingBuyTimes(self._activityId)

	goutil.setActive(self._redpointGo, cur > 0)
end

function ElizabethactgameView:_onBallBoomed()
	removetimer(self._onTicking, self)
	self:_updateAoqiLihuiState("idle", true)
	self._txtRemaingTime:SetText(math.ceil(self._maxGameTime))

	local text = "吹气过猛，泡泡爆炸，本次无法获得积分奖励噢！"

	self._gameBall1:endGame()
	self._gameBall2:endGame()
	self._gameBall1:setIsBloom(false)
	self._gameBall2:setIsBloom(false)
	self:_initGame()
	TipsFacade.instance:openTipWindowNoX("提示", text, function()
		ElizabethGameAgent.instance:sendPM_ElizabethGameQuitGameReq(self._activityId)
	end)
end

function ElizabethactgameView:_onClickAddTimes()
	ElizabethgameController.instance:addTimes(self._activityId)
end

function ElizabethactgameView:_onElizabethGameBallBoomAniDone()
	self:_updateAoqiLihuiState("baoza", false)
end

function ElizabethactgameView:_playViewEffect()
	local effName = "20240209/changanguwu/fx_ui_changanguwu_fenwei02.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)

	self._effectHandler.hideEffWhileNotOnTop = false
end

function ElizabethactgameView:_playEndEffect()
	if self._endEffectHandler then
		UIEffectManager.instance:stopEffect(self._endEffectHandler)
	end

	local effName = "20240209/changanguwu/fx_ui_changanguwu_lihua.prefab"

	self._endEffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	self._endEffectHandler:setParent(self.mainGO.transform)
	self._endEffectHandler:setLocalPos(0, 0, 0)
	self._endEffectHandler:setScale(1)

	self._endEffectHandler.hideEffWhileNotOnTop = false
end

return ElizabethactgameView
