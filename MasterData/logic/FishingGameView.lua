-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/view/FishingGameView.lua

module("logic.extensions.fishinggame.view.FishingGameView", package.seeall)

local FishingGameView = class("FishingGameView", ViewComponent)
local STATE_INIT = "STATE_INIT"
local STATE_READY = "STATE_READY"
local STATE_RUNING = "STATE_RUNING"
local STATE_PAUSE = "STATE_PAUSE"
local STATE_GAME_END = "STATE_GAME_END"

function FishingGameView:ctor()
	FishingGameView.super.ctor(self)
end

function FishingGameView:buildUI()
	FishingGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._btnStart = self:getGo("btnStart")
	self._txtScore = self:getTxt("score/txtScore")
	self._txtTime = self:getTxt("time/txtTime")
	self._heartList = {
		self:getGo("heart/imgHeart1"),
		self:getGo("heart/imgHeart2"),
		self:getGo("heart/imgHeart3")
	}
	self._playerCell = self:getGo("playerCell")
	self._playerRoot = self:getGo("map/player")
	self._flyitem = self:getGo("flyitem")
	self._textCon = self:getGo("map/textCon")
	self._fishCell = self:getGo("map/fish/fishCell")
	self._thunderCell = self:getGo("map/powerGrid/thunderCell")
	self._treasureCell = self:getGo("map/treasureBox/treasureCell")
	self._grassCell = self:getGo("map/grass/grassCell")
	self._eff = self:getGo("eff")

	FishingGameGameController.instance:initGame()
	FishingGameGameController.instance:setUnitComTemplate(FishingGameEnum.UnitType.Player, self._playerCell)
	FishingGameGameController.instance:setPlayerRoot(self._playerRoot)
	FishingGameGameController.instance:setUnitComTemplate(FishingGameEnum.FishType.Fish, self._fishCell)
	FishingGameGameController.instance:setUnitComTemplate(FishingGameEnum.FishType.AttackFish, self._fishCell)
	FishingGameGameController.instance:setUnitComTemplate(FishingGameEnum.FishType.ElectricEel, self._fishCell)
	FishingGameGameController.instance:setUnitComTemplate(FishingGameEnum.FishType.TreasureBox, self._treasureCell)
	FishingGameGameController.instance:setUnitComTemplate(FishingGameEnum.FishType.LimitTreasureBox, self._treasureCell)
	FishingGameGameController.instance:setUnitComTemplate(FishingGameEnum.FishType.PowerGrid, self._thunderCell)
	FishingGameGameController.instance:setUnitComTemplate(FishingGameEnum.FishType.Grass, self._grassCell)
	self:_initFSM()
end

function FishingGameView:bindEvents()
	FishingGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)

	self._pointerDownBtnLeftHandler = PointerDownHandler.Get(self._btnLeft):AddLuaHandler(function(_go, eventData)
		self:_onPointerDown(eventData, FishingGameEnum.BoatDirect.Left)
	end)
	self._pointerUpBtnLeftHandler = PointerUpHandler.Get(self._btnLeft):AddLuaHandler(function(_go, eventData)
		self:_onPointerUp(eventData, FishingGameEnum.BoatDirect.Left)
	end)
	self._pointerDownBtnRightHandler = PointerDownHandler.Get(self._btnRight):AddLuaHandler(function(_go, eventData)
		self:_onPointerDown(eventData, FishingGameEnum.BoatDirect.Right)
	end)
	self._pointerUpBtnRightHandler = PointerUpHandler.Get(self._btnRight):AddLuaHandler(function(_go, eventData)
		self:_onPointerUp(eventData, FishingGameEnum.BoatDirect.Right)
	end)
end

function FishingGameView:unbindEvents()
	FishingGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)

	if self._pointerUpBtnLeftHandler then
		PointerUpHandler.Get(self._btnLeft):RemoveLuaHandler(self._pointerUpBtnLeftHandler)

		self._pointerUpBtnLeftHandler = nil
	end

	if self._pointerUpBtnRightHandler then
		PointerUpHandler.Get(self._btnRight):RemoveLuaHandler(self._pointerUpBtnRightHandler)

		self._pointerUpBtnRightHandler = nil
	end

	if self._pointerDownBtnLeftHandler then
		PointerDownHandler.Get(self._btnLeft):RemoveLuaHandler(self._pointerDownBtnLeftHandler)

		self._pointerDownBtnLeftHandler = nil
	end

	if self._pointerDownBtnRightHandler then
		PointerDownHandler.Get(self._btnRight):RemoveLuaHandler(self._pointerDownBtnRightHandler)

		self._pointerDownBtnRightHandler = nil
	end
end

function FishingGameView:onEnter()
	FishingGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_FishingGameStartGameRes, self._onStartGameRes, self)
	self.addGEvent(self, GlobalNotify.PM_FishingGameEndGameRes, self._onEndGameRes, self)
	self.addGEvent(self, GlobalNotify.FishingGameShowScoreTips, self._onShowScoreTips, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 607001
	end

	self._actCfg = FishingGameConfig.instance:getActivityCfg(self._activityId) or {}
	self._isManualExit = false

	self._stateMachine:startTimer()
	self._stateMachine:gotoState(STATE_INIT)
	self._stateMachine:gotoState(STATE_READY)
	self:playViewEffectUniGo("20260626/diaoyuxiaoyouxi/fx_ui_diaoyu_fw.prefab", self._eff, self.mainGO.transform, true, nil, nil)
	AQAFSimpleFloatTipsMgr.instance:addItemType(AQAFSimpleFloatTipsMgr.TYPE_SIMPLE, self._flyitem, FishingGameFloatTextItem, 100)
end

function FishingGameView:onExit()
	FishingGameView.super.onExit(self)

	if self._stateMachine then
		self._stateMachine:gotoState(STATE_GAME_END)
		self._stateMachine:stopTimer()
	end

	FishingGameGameController.instance:destroyGame()
	AQAFSimpleFloatTipsMgr.instance:clearAll()
	self:stopViewEffectUniGo(self._eff)
end

function FishingGameView:destroyUI()
	FishingGameGameController.instance:destroyGame()
end

function FishingGameView:_initFSM()
	self._stateMachine = SimpleFSM.New()

	self._stateMachine:addState(STATE_INIT, GameUtil.handler(self._onEnterInit, self), nil, nil)
	self._stateMachine:addState(STATE_READY, GameUtil.handler(self._onEnterReady, self), nil, nil)
	self._stateMachine:addState(STATE_RUNING, GameUtil.handler(self._onEnterRunning, self), nil, GameUtil.handler(self._onRunning, self))
	self._stateMachine:addState(STATE_PAUSE, nil, nil, nil)
	self._stateMachine:addState(STATE_GAME_END, GameUtil.handler(self._onEnterGameEnd, self))

	local linkedList = {
		[STATE_INIT] = {
			STATE_READY
		},
		[STATE_READY] = {
			STATE_RUNING,
			STATE_GAME_END
		},
		[STATE_RUNING] = {
			STATE_PAUSE,
			STATE_GAME_END
		},
		[STATE_PAUSE] = {
			STATE_RUNING,
			STATE_GAME_END
		},
		[STATE_GAME_END] = {
			STATE_INIT
		}
	}

	self._stateMachine:addLinkByLinkedList(linkedList)
end

function FishingGameView:_onEnterInit()
	FishingGameGameController.instance:setActivityId(self._activityId)
	FishingGameGameController.instance:resetGame()
	self:_updateGameInfo()
end

function FishingGameView:_onEnterReady()
	goutil.setActive(self._btnStart, true)
	FishingGameGameController.instance:setBoatDirect(FishingGameEnum.BoatDirect.None)
end

function FishingGameView:_onEnterRunning()
	goutil.setActive(self._btnStart, false)

	if not FishingGameGameController.instance:isGameStarted() then
		FishingGameGameController.instance:startGame()
	end
end

function FishingGameView:_onRunning()
	FishingGameGameController.instance:updateGame()
	self:_updateGameInfo()

	if FishingGameGameController.instance:isGameOver() then
		self._stateMachine:gotoState(STATE_GAME_END)
	end
end

function FishingGameView:_onEnterGameEnd()
	FishingGameGameController.instance:setBoatDirect(FishingGameEnum.BoatDirect.None)

	if FishingGameGameController.instance:isGameStarted() and FishingGameGameController.instance:isGameOver() and not FishingGameGameController.instance:hasSendEnd() then
		FishingGameGameController.instance:markEndSent()

		local score = FishingGameGameController.instance:getScore()

		FishingGameController.instance:sendPM_FishingGameEndGameReq(self._activityId, score)
	end
end

function FishingGameView:_updateGameInfo()
	local score = FishingGameGameController.instance:getScore()
	local leftTime = FishingGameGameController.instance:getLeftTime()
	local blood = FishingGameGameController.instance:getBlood()

	self._txtScore.text = string.format(lang("得分: <color=#FDEB96>%s</color>"), score)
	self._txtTime.text = string.format(lang("倒计时：%s秒"), leftTime)

	for i, heart in ipairs(self._heartList) do
		GameUtil.SetActive(heart, i <= blood)
	end
end

function FishingGameView:_onShowScoreTips(score, posX, posY)
	local content = string.format("+%s", checknumber(score))

	AQAFSimpleFloatTipsMgr.instance:flyText(AQAFSimpleFloatTipsMgr.TYPE_SIMPLE, content, self._textCon, posX, posY)
end

function FishingGameView:_onClickStart()
	if self._stateMachine.currStateName ~= STATE_READY then
		return
	end

	FishingGameController.instance:sendPM_FishingGameStartGameReq(self._activityId)
end

function FishingGameView:_onStartGameRes(status)
	if checknumber(status) == 0 and self._stateMachine.currStateName == STATE_READY then
		self._stateMachine:gotoState(STATE_RUNING)
	end
end

function FishingGameView:_onEndGameRes()
	if self._isManualExit then
		self:close()

		return
	end

	TipsFacade.instance:openTipWindowNoX(lang("提示"), lang("游戏结束！"), function()
		self:close()
	end, lang("确定"))
end

function FishingGameView:_onClickClose()
	local lastStateName = self._stateMachine.currStateName

	if lastStateName == STATE_RUNING then
		self._stateMachine:gotoState(STATE_PAUSE)
	end

	local function cencelFunc()
		if self._stateMachine.currStateName == STATE_PAUSE and lastStateName == STATE_RUNING then
			self._stateMachine:gotoState(STATE_RUNING)
		end
	end

	TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否确认退出游戏？"), function()
		self._isManualExit = true

		self:close()
	end, cencelFunc, lang("确定"), lang("取消"))
end

function FishingGameView:_onClickTip()
	if not string.nilorempty(self._actCfg.ruleKey) then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function FishingGameView:_onPointerDown(eventData, direct)
	if self._stateMachine.currStateName == STATE_RUNING then
		FishingGameGameController.instance:setBoatDirect(direct)
	end
end

function FishingGameView:_onPointerUp(eventData, direct)
	FishingGameGameController.instance:setBoatDirect(FishingGameEnum.BoatDirect.None)
end

return FishingGameView
