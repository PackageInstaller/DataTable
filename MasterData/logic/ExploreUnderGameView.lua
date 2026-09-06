-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderGameView.lua

module("logic.extensions.exploreunder.view.ExploreUnderGameView", package.seeall)

local ExploreUnderGameView = class("ExploreUnderGameView", ViewComponent)

function ExploreUnderGameView:buildUI()
	ExploreUnderGameView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnPull = self:getGo("btnPull")
	self._btnTip = self:getGo("btnTip")
	self._btnStart = self:getGo("btnStart")
	self._timer = self:getGo("timer")
	self._txtTimer = goutil.findChildTextComponent(self._timer, "txt")
	self._comSpine = self:getGo("comSpine")
	self._posMove = self:getGo("pos_move")
	self._spinePet = self:getGo("comSpine/pet")
	self._spinePlayer = self:getGo("comSpine/player")
	self._spinePetHand = self:getGo("comSpine/pethand")
	self._spinePlayerHand = self:getGo("comSpine/playerhand")
end

function ExploreUnderGameView:bindEvents()
	ExploreUnderGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnPull, self._onClickPull, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function ExploreUnderGameView:unbindEvents()
	ExploreUnderGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPull)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnTip)
end

function ExploreUnderGameView:onEnter()
	ExploreUnderGameView.super.onEnter(self)

	self._curEventInfo = ExploreUnderModel.instance:getCurGridInfo()

	local curEventState = ExploreUnderModel.instance:getCurEventState()

	if self._curEventInfo.eventType ~= 3 or curEventState ~= ExploreUnderEnum.EventState_Orgin then
		self:close()

		return
	end

	local eventParam = checkint(self._curEventInfo.eventParm)
	local curActId = ExploreUnderModel.instance:getActId()
	local curActCfg = ExploreUnderConfig.instance:getActfg(curActId)
	local curLevel = ExploreUnderModel.instance:getCurLevel()
	local curLevelCfg = ExploreUnderConfig.instance:getLevelCfg(curActCfg.levelPlanId, curLevel)

	self._gameCfg = ExploreUnderConfig.instance:getGameEventCfg(curLevelCfg.event_plan_3, eventParam)

	if not self._gameCfg then
		self:close()

		return
	end

	self:_resetGameState()
	GlobalDispatcher:addListener(GlobalNotify.ExploreUnderEventInfoChange, self._onHandleGame, self)
end

function ExploreUnderGameView:onExit()
	ExploreUnderGameView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ExploreUnderEventInfoChange, self._onHandleGame, self)
	removetimer(self._onTimer, self)
	removetimer(self._onPetMoveRope, self)

	if self._lastTween then
		self._lastTween:Kill()
	end

	if self._lastEff then
		UIEffectManager.instance:stopEffect(self._lastEff)

		self._lastEff = nil
	end
end

function ExploreUnderGameView:_onClickClose()
	if self._isGaming then
		FloatWordMgr.instance:show(lang("游戏中"))

		return
	end

	self:close()
end

function ExploreUnderGameView:_onClickTip()
	if self._isGaming then
		FloatWordMgr.instance:show(lang("游戏中"))

		return
	end

	UIStateManager.instance:open(ViewName.RulesView, "exploreundergamerule")
end

function ExploreUnderGameView:_onClickStart()
	if self._lastEff then
		UIEffectManager.instance:stopEffect(self._lastEff)

		self._lastEff = nil
	end

	self._lastEff = UIEffectManager.instance:playEffect(self, "20220602/liliangmijing/fx_ui_kuangdianbahe.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self._btnPull.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)

	self:_onGameStart()
end

function ExploreUnderGameView:_onClickPull()
	if self._isGaming then
		RoleObjectPool.instance:playAnimation(self._spinePlayer, "bahe_hard", false, function()
			RoleObjectPool.instance:playAnimation(self._spinePlayer, "bahe_normal", true)
		end, true)
		RoleObjectPool.instance:playAnimation(self._spinePlayerHand, "bahe_hard", false, function()
			RoleObjectPool.instance:playAnimation(self._spinePlayerHand, "bahe_normal", true)
		end, true)
		self:_onMoveRope(true)
	end
end

function ExploreUnderGameView:_resetGameState()
	self._isGaming = false

	goutil.setActive(self._btnStart, true)
	RoleObjectPool.instance:playAnimation(self._spinePet, "bahe_idle", true)
	RoleObjectPool.instance:playAnimation(self._spinePetHand, "bahe_idle", true)
	RoleObjectPool.instance:playAnimation(self._spinePlayer, "bahe_idle", true)
	RoleObjectPool.instance:playAnimation(self._spinePlayerHand, "bahe_idle", true)
	GameUtil.setLocalPos(self._comSpine, 0, 0, 0)
	GameUtil.setLocalPos(self._posMove, 0, 0, 0)
	goutil.setActive(self._timer, false)
end

function ExploreUnderGameView:_onGameStart()
	self._isGaming = true
	self._curTimer = self._gameCfg.countDown or 0
	self._petStep = self._gameCfg.petStep or {
		1
	}
	self._playerStep = self._gameCfg.playerStep or 0
	self._curPosX = 0

	goutil.setActive(self._btnStart, false)
	RoleObjectPool.instance:playAnimation(self._spinePet, "bahe_hard", true)
	RoleObjectPool.instance:playAnimation(self._spinePetHand, "bahe_hard", true)
	RoleObjectPool.instance:playAnimation(self._spinePlayer, "bahe_normal", true)
	RoleObjectPool.instance:playAnimation(self._spinePlayerHand, "bahe_normal", true)

	self._txtTimer.text = langPara("%s秒", self._curTimer)

	goutil.setActive(self._timer, true)
	settimer(0.1, self._onTimer, self)
	settimer(0.5, self._onPetMoveRope, self)
end

function ExploreUnderGameView:_onGameEnd()
	self._isGaming = false

	RoleObjectPool.instance:playAnimation(self._spinePet, "bahe_idle", true)
	RoleObjectPool.instance:playAnimation(self._spinePetHand, "bahe_idle", true)
	RoleObjectPool.instance:playAnimation(self._spinePlayer, "bahe_idle", true)
	RoleObjectPool.instance:playAnimation(self._spinePlayerHand, "bahe_idle", true)
	GameUtil.setLocalPos(self._comSpine, 0, 0, 0)
	goutil.setActive(self._timer, false)
	removetimer(self._onTimer, self)
	removetimer(self._onPetMoveRope, self)
end

function ExploreUnderGameView:_onGameLose()
	if self._isGaming then
		self._curResult = false

		ExploreUnderController.instance:dealEvent(ExploreUnderModel.EventAction.finishGame, {
			{
				value = "0",
				key = ExploreUnderModel.EventExtraParamKey.win
			}
		})
		self:_onGameEnd()
	end
end

function ExploreUnderGameView:_onGameWin()
	if self._isGaming then
		self._curResult = true

		ExploreUnderController.instance:dealEvent(ExploreUnderModel.EventAction.finishGame, {
			{
				value = "1",
				key = ExploreUnderModel.EventExtraParamKey.win
			}
		})
		self:_onGameEnd()
	end
end

function ExploreUnderGameView:_onHandleGame()
	local curEventState = ExploreUnderModel.instance:getCurEventState()

	if curEventState == ExploreUnderEnum.EventState_Finish then
		local text = self._curResult and langPara("挑战成功") or langPara("挑战失败")

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
			ExploreUnderModel.instance:ShowCI()
		end)
	end
end

function ExploreUnderGameView:_onTimer()
	self._curTimer = self._curTimer - 0.1
	self._txtTimer.text = langPara("%.1f秒", self._curTimer)

	if self._curTimer <= 0 then
		self:_onGameLose()
	end
end

function ExploreUnderGameView:_onPetMoveRope()
	self:_onMoveRope()
end

function ExploreUnderGameView:_onMoveRope(isAdd)
	if self._lastTween then
		self._lastTween:Kill()
	end

	if isAdd then
		self._curPosX = self._curPosX + self._playerStep
	else
		local petStepId = math.random(#self._petStep)

		self._curPosX = self._curPosX - self._petStep[petStepId]
	end

	if self._curPosX > 200 then
		self:_onGameWin()
	elseif self._curPosX < -200 then
		self:_onGameLose()
	end

	GameUtil.setLocalPos(self._posMove, self._curPosX, 0, 0)

	self._lastTween = self._comSpine.transform:DOMove(self._posMove.transform.position, 0.2)
end

return ExploreUnderGameView
