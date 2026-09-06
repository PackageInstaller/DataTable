-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirePowerContestGameView.lua

module("logic.extensions.firepowercontest.view.FirePowerContestGameView", package.seeall)

local FirePowerContestGameView = class("FirePowerContestGameView", ViewComponent)

function FirePowerContestGameView:ctor()
	FirePowerContestGameView.super.ctor(self)
end

function FirePowerContestGameView:unbindEvents()
	FirePowerContestGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnHangupTip)
end

function FirePowerContestGameView:bindEvents()
	FirePowerContestGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnHangupTip, self._onClickHangupTip, self)
end

function FirePowerContestGameView:buildUI()
	FirePowerContestGameView.super.buildUI(self)

	self._txtRivalName = self:getTxt("item_1/txtName")
	self._txtMyName = self:getTxt("item_2/txtName")
	self._imgRivalIcon = self:getGo("item_1/imgIcon")
	self._imgMyIcon = self:getGo("item_2/imgIcon")
	self._itemGo1 = self:getGo("item_1")
	self._itemGo2 = self:getGo("item_2")
	self._ready = self:getGo("ready")
	self._gameOver = self:getGo("gameover")
	self._otherLead = self:getGo("otherLead")
	self._myLead = self:getGo("myLead")
	self._txtCountDown = self:getTxt("txtCountDown")
	self._itemCell = self:getGo("item_2/itemCell")
	self._bulletCell = self:getGo("bulletCell")
	self._comboCell = self:getGo("comobCell")
	self._txtAddScoreCell = self:getGo("txtAddScoreCell")
	self._effectCell = self:getGo("effectCell")
	self._txtReady = self:getTxt("ready/tip/txt2")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnCloseGo = self:getGo("leftTop/btnClose")
	self._btnHangupTip = self:getGo("btnHangup")

	goutil.setActive(self._btnHangupTip.gameObject, false)
end

function FirePowerContestGameView:onExit()
	FirePowerContestGameView.super.onExit(self)
	removetimer(self._tick, self)
	removetimer(self._deactiveReadyLabel, self)
	removetimer(self._reqStartGame, self)
	removetimer(self._reqEndGame, self)
	removetimer(self._tickSecond, self)

	local controller = FirePowerContestController.instance

	controller:unregisterLocalNotify(FirePowerContestController.NotifyGameStart, self._onStartGame, self)
	controller:unregisterLocalNotify(FirePowerContestController.NotifyGameNext, self._onNextGame, self)
	controller:unregisterLocalNotify(FirePowerContestController.NotifyLaunch, self._onRivalLaunch, self)
	controller:unregisterLocalNotify(FirePowerContestController.NotifyHit, self._onRivalHit, self)
	controller:unregisterLocalNotify(FirePowerContestController.NotifyLeaveGame, self._onLeaveGame, self)
	controller:unregisterLocalNotify(FirePowerContestController.NotifyGameEnd, self._onGameEnd, self)
	controller:unregisterLocalNotify(FirePowerContestController.AfterLeaveGameResponse, self._onLeaveGameResponse, self)
	self:disposePanel()

	if self._pool then
		self._pool:dispose()

		self._pool = nil
	end

	uGuiUtil.clearImage(self._imgRivalIcon)
	uGuiUtil.clearImage(self._imgMyIcon)
end

function FirePowerContestGameView:disposePanel()
	if self._gamePanel_1 then
		self._gamePanel_1:dispose()

		self._gamePanel_1 = nil
	end

	if self._gamePanel_2 then
		self._gamePanel_2:dispose()

		self._gamePanel_2 = nil
	end
end

function FirePowerContestGameView:onEnter()
	FirePowerContestGameView.super.onEnter(self)
	goutil.setActive(self._itemCell, false)
	goutil.setActive(self._bulletCell, false)
	goutil.setActive(self._comboCell, false)
	goutil.setActive(self._txtAddScoreCell, false)
	goutil.setActive(self._effectCell, false)
	goutil.setActive(self._otherLead, false)
	goutil.setActive(self._myLead, false)
	goutil.setActive(self._ready, false)
	goutil.setActive(self._gameOver, false)

	if FirePowerContestConfig.debugClient then
		FirePowerContestModel.instance:reqStartGame()
	end

	self._handler = FirePowerContestModel.instance.handler
	self._data = self._handler.data
	self._txtCountDown.text = ""

	local controller = FirePowerContestController.instance

	controller:registerLocalNotify(FirePowerContestController.NotifyGameStart, self._onStartGame, self)
	controller:registerLocalNotify(FirePowerContestController.NotifyGameNext, self._onNextGame, self)
	controller:registerLocalNotify(FirePowerContestController.NotifyLaunch, self._onRivalLaunch, self)
	controller:registerLocalNotify(FirePowerContestController.NotifyHit, self._onRivalHit, self)
	controller:registerLocalNotify(FirePowerContestController.NotifyLeaveGame, self._onLeaveGame, self)
	controller:registerLocalNotify(FirePowerContestController.NotifyGameEnd, self._onGameEnd, self)
	controller:registerLocalNotify(FirePowerContestController.AfterLeaveGameResponse, self._onLeaveGameResponse, self)
	self:disposePanel()

	self._pool = FirePowerContestPool.New(self._bulletCell, self._itemCell, self._comboCell, self._txtAddScoreCell, self._effectCell)
	self._gamePanel_1 = FirePowerContestGamePanel.New(self._itemGo1, self._pool, self)
	self._gamePanel_2 = FirePowerContestMyGamePanel.New(self._itemGo2, self._pool, self)

	self._gamePanel_1:updateScoreCount(self._data.rivalScore)
	self._gamePanel_2:updateScoreCount(self._data.myScore)

	self._activityConf = FirePowerContestConfig.instance:getGameActivityConf()

	self:_initUserInfos()
	goutil.setActive(self._btnCloseGo, false)
end

function FirePowerContestGameView:onEnterFinished()
	FirePowerContestGameView.super.onEnterFinished(self)
	goutil.setActive(self._ready, true)

	self._txtReady.text = lang("开始游戏")

	settimer(2, self._deactiveReadyLabel, self, false)
	settimer(1.9, self._reqStartGame, self, false)
	UIStateManager.instance:popByName(ViewName.FirePowerContestPrepareView)
end

function FirePowerContestGameView:_deactiveReadyLabel()
	goutil.setActive(self._ready, false)
end

function FirePowerContestGameView:_reqStartGame()
	self._handler:reqEnterGame()
end

function FirePowerContestGameView:_onStartGame(status)
	if status == 0 then
		goutil.setActive(self._btnCloseGo, true)

		self._cdTimeStamp = self._data.startTimeClient + self._data.gameStageConf.stageTime * 1000

		self:_resetStage()
		settimer(FirePowerContestConfig.tick, self._tick, self)
		settimer(0.2, self._tickSecond, self)
		self:_tickSecond()

		if self._data:isSelfHangup() then
			goutil.setActive(self._btnHangupTip.gameObject, true)
		end

		FirePowerContestController.instance:callBackStartTourArena()
	end
end

function FirePowerContestGameView:_onNextGame(status)
	if status == 0 then
		self:_playNextStageAnim()

		if self._data:isSelfHangup() then
			goutil.setActive(self._btnHangupTip.gameObject, true)
		end
	end
end

function FirePowerContestGameView:_doNextGame()
	goutil.setActive(self._ready, false)

	self._cdTimeStamp = self._data.startTimeClient + self._data.gameStageConf.stageTime * 1000

	self:_resetStage()
	self:_tickSecond()

	local isMyLead = self._data.myScore > self._data.rivalScore
	local isRivalLead = self._data.myScore < self._data.rivalScore

	goutil.setActive(self._otherLead, isRivalLead)
	goutil.setActive(self._myLead, isMyLead)

	if isMyLead or isRivalLead then
		self._cdLead = (UnityEngine.Time.realtimeSinceStartup + 5) * 1000
	end
end

function FirePowerContestGameView:_resetStage()
	print("........................FirePowerContestGameView:_resetStage")

	if self._gamePanel_1 then
		self._gamePanel_1:reset()
	end

	if self._gamePanel_2 then
		self._gamePanel_2:reset()
	end
end

function FirePowerContestGameView:_tickSecond()
	local nowTime = UnityEngine.Time.realtimeSinceStartup * 1000
	local delta = (self._cdTimeStamp - nowTime) / 1000
	local second = math.max(math.floor(delta), 0)

	self._txtCountDown.text = self._cd2Next ~= nil and "" or langPara("FirePowerContestGameView__2", second)

	if second == 0 then
		if self._gamePanel_1 then
			self._gamePanel_1:lock()
		end

		if self._gamePanel_2 then
			self._gamePanel_2:lock()
		end
	end

	if self._cdLead ~= nil and nowTime >= self._cdLead then
		self._cdLead = nil

		goutil.setActive(self._otherLead, false)
		goutil.setActive(self._myLead, false)
	end

	if self._cd2Next ~= nil then
		if nowTime >= self._cd2Next then
			self._cd2Next = nil

			self:_doNextGame()
		end
	elseif FirePowerContestConfig.debugClient and math.floor(delta) == -2 then
		self._handler:debugNext()
	end
end

function FirePowerContestGameView:_tick()
	if self._cd2Next == nil then
		if self._gamePanel_1 then
			self._gamePanel_1:tick()
		end

		if self._gamePanel_2 then
			self._gamePanel_2:tick()
		end
	end
end

function FirePowerContestGameView:_initUserInfos()
	self._txtRivalName.text = self._data.rivalUserInfo.userName
	self._txtMyName.text = RoleModel.instance:getUserName()

	local function getIconUrl(userId)
		local iconTypeT = self._data:getIconType(userId)
		local iconUrl = self._activityConf[string.format("iconPath_%d", iconTypeT)]

		return GameUrl.getBigbgFolderUrl("firepowercontest", iconUrl)
	end

	uGuiUtil.setSpriteToImage(self._imgRivalIcon, uGuiUtil.SpriteType.BigBg, getIconUrl(self._data.rivalUserInfo.userId))
	uGuiUtil.setSpriteToImage(self._imgMyIcon, uGuiUtil.SpriteType.BigBg, getIconUrl(self._data.myUserInfo.userId))
end

function FirePowerContestGameView:_onRivalLaunch(angle, bulletId, launchTimes)
	self._gamePanel_1:launchBullet(angle, bulletId, launchTimes)
end

function FirePowerContestGameView:_onRivalHit(msg)
	self._gamePanel_1:syncHit(msg)
	self._gamePanel_1:updateScoreCount(self._data.rivalScore)
end

function FirePowerContestGameView:_onLeaveGame(userId)
	if userId == self._data.rivalUserInfo.userId then
		self._gamePanel_1:syncLeaveGame()
	end
end

function FirePowerContestGameView:_onGameEnd()
	self:disposePanel()

	if self._data.isSelfLeave or self._data.isLeaving then
		return
	end

	goutil.setActive(self._gameOver, true)
	settimer(2, self._reqEndGame, self, false)
end

function FirePowerContestGameView:_onLeaveGameResponse()
	self._handler:reqEndGame()
	self:close()
end

function FirePowerContestGameView:_reqEndGame()
	self._handler:reqEndGame()
	self:close()
end

function FirePowerContestGameView:_playNextStageAnim()
	goutil.setActive(self._ready, true)

	self._txtReady.text = langPara("第%s关", ConstString.ChineseNumber[self._data.curStage])
	self._cd2Next = (UnityEngine.Time.realtimeSinceStartup + 2) * 1000
end

function FirePowerContestGameView:_onClickClose()
	TipsFacade.instance:openPopupWindow(lang("tip"), lang("FirePowerContestGameView__1"), function()
		self._handler:reqLeaveGame()
	end, nil, lang("confirm"), lang("cancel"))
end

function FirePowerContestGameView:_onClickHangupTip()
	goutil.setActive(self._btnHangupTip.gameObject, false)
end

return FirePowerContestGameView
