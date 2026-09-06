-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/domadvcopy/DomAdvCopyBasePinGameTypeView.lua

module("logic.extensions.pingame.domadvcopy.DomAdvCopyBasePinGameTypeView", package.seeall)

local DomAdvCopyBasePinGameTypeView = class("DomAdvCopyBasePinGameTypeView", ViewComponent)

function DomAdvCopyBasePinGameTypeView:ctor()
	return
end

function DomAdvCopyBasePinGameTypeView:buildUI()
	DomAdvCopyBasePinGameTypeView.super.buildUI(self)

	self._obstacle = self:getGo("obstacle")
	self._needle = self:getGo("needle")

	goutil.setActive(self._obstacle, false)
	goutil.setActive(self._needle, false)

	self._rootCellList = {}

	local root1 = self:getGo("root1")
	local root2 = self:getGo("root2")

	table.insert(self._rootCellList, DomAdvCopyPinGameRootCell.New(root1, self._obstacle, self._needle))

	if root2 then
		table.insert(self._rootCellList, DomAdvCopyPinGameRootCell.New(root2, self._obstacle, self._needle))
	end

	self._btnShoot = self:getBtn("btnShoot")
	self._txtLeftCount = self:getTxt("txtLeftCount")
end

function DomAdvCopyBasePinGameTypeView:bindEvents()
	DomAdvCopyBasePinGameTypeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnShoot, self._onClickShoot, self)
end

function DomAdvCopyBasePinGameTypeView:unbindEvents()
	DomAdvCopyBasePinGameTypeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnShoot)
end

function DomAdvCopyBasePinGameTypeView:onEnter()
	DomAdvCopyBasePinGameTypeView.super.onEnter(self)

	local params = self:getOpenParam()

	self._stagePlanId = params[1]
	self._stageId = params[2]
	self._mode = params[3]
	self._domAdvParams = params[4]

	PinGameController.instance:registerLocalNotify(PinGameController.StartGameEvent, self._onStartGame, self)
	PinGameController.instance:registerLocalNotify(PinGameController.ClickExitEvent, self._onExitGame, self)
	PinGameController.instance:registerLocalNotify(PinGameController.UpdateNeedleLeftNumEvent, self._onUpdateNeedleLeftNum, self)
	PinGameController.instance:registerLocalNotify(PinGameController.PlaySuccessTween, self._handlePlaySuccessTween, self)
	self.addGEvent(self, GlobalNotify.PinGameRecoverRes, self._onPinGameRecoverRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_DomainAdventureNotifyActionRes, self._handlePM_DomainAdventureNotifyActionRes, self)
	PinGameController.instance:localNotify(PinGameController.ReadyGoEvent)

	self._reviveData = {
		maxNum = 0,
		curNum = 0
	}

	self:_initGameData()
	self:_initGameState()
end

function DomAdvCopyBasePinGameTypeView:onExit()
	DomAdvCopyBasePinGameTypeView.super.onExit(self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.StartGameEvent, self._onStartGame, self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.ClickExitEvent, self._onExitGame, self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.UpdateNeedleLeftNumEvent, self._onUpdateNeedleLeftNum, self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.PlaySuccessTween, self._handlePlaySuccessTween, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_DomainAdventureNotifyActionRes, self._handlePM_DomainAdventureNotifyActionRes, self)
	self:_stopDelayTween()
	self:_onExitGame()
end

function DomAdvCopyBasePinGameTypeView:_onClickShoot()
	printInfo("test DomAdvCopyBasePinGameTypeView:_onClickShoot")
	PinGameController.instance:localNotify(PinGameController.ClickShootEvent)
end

function DomAdvCopyBasePinGameTypeView:_onStartGame()
	printInfo("test DomAdvCopyBasePinGameTypeView:_onStartGame 开始游戏")
	self:_startGame()
end

function DomAdvCopyBasePinGameTypeView:_onExitGame()
	printInfo("test DomAdvCopyBasePinGameTypeView:_onExitGame")

	for i, v in ipairs(self._rootCellList) do
		v:clearGameState()
	end
end

function DomAdvCopyBasePinGameTypeView:_onUpdateNeedleLeftNum(num, sucHitCount)
	self._curCount = sucHitCount

	local left = Mathf.Max(self._maxCount - sucHitCount, 0)

	self._txtLeftCount.text = string.format("%d", left)
end

function DomAdvCopyBasePinGameTypeView:_onPinGameRecoverRes()
	printInfo("test DomAdvCopyBasePinGameTypeView:_onPinGameRecoverRes")

	self._reviveData.curNum = self._reviveData.curNum + 1

	self:_playFromPause()
end

function DomAdvCopyBasePinGameTypeView:_getGameData()
	return (PinGameConfig.instance:getStageParam(self._stagePlanId, self._stageId))
end

function DomAdvCopyBasePinGameTypeView:_initGameData()
	self._gameData = self:_getGameData()
end

function DomAdvCopyBasePinGameTypeView:_initGameState()
	GameUtil.SetActive(self._obstacle, false)
	GameUtil.SetActive(self._needle, false)

	self._curCount = 0
	self._maxCount = 0
	self._isFinishEndTween = false
	self._domAdvMsg = nil

	for i, v in ipairs(self._rootCellList) do
		if self._gameData[i] then
			v:initGameState(self._gameData[i], self._mode, self._stagePlanId, self._stageId, self._reviveData)

			self._maxCount = self._gameData[i].winCount
		else
			printError("DomAdvCopyBasePinGameTypeView:_initGameState 游戏数据缺失:", "stagePlanId = ", self._stagePlanId, "stageId = ", self._stageId)
		end
	end

	self:_onUpdateNeedleLeftNum(self._maxCount, 0)
end

function DomAdvCopyBasePinGameTypeView:_startGame()
	for i, v in ipairs(self._rootCellList) do
		v:startGameState()
	end
end

function DomAdvCopyBasePinGameTypeView:_resetGame()
	printInfo("test DomAdvCopyBasePinGameTypeView:_resetGame")
	self:_initGameState()
	self:_startGame()
end

function DomAdvCopyBasePinGameTypeView:_playFromPause()
	printInfo("test DomAdvCopyBasePinGameTypeView:_playFromPause")

	for i, v in ipairs(self._rootCellList) do
		v:playFromPause()
	end
end

function DomAdvCopyBasePinGameTypeView:_handlePlaySuccessTween()
	local score = self._curCount
	local activityId = self._domAdvParams.activityId
	local blockId = self._domAdvParams.blockId
	local clientKey = self._domAdvParams.clientKey
	local serverKey = self._domAdvParams.serverKey
	local extParams = {}

	if score > 0 then
		extParams.encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, {
			score
		})
		extParams.score = score
	else
		extParams.removeStash = 1
	end

	local jsonExPrams = GameUtil.jsonToString(extParams)

	DomainAdventureController.instance:sendPM_DomainAdventureActionReq(activityId, blockId, jsonExPrams, nil)
	self:_playDelayTween(function()
		self._isFinishEndTween = true

		self:_tryPushResultView()
	end)
end

function DomAdvCopyBasePinGameTypeView:_handlePM_DomainAdventureNotifyActionRes(msg)
	self._domAdvMsg = msg

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	self:_tryPushResultView()
end

function DomAdvCopyBasePinGameTypeView:_tryPushResultView()
	if self._domAdvMsg and self._isFinishEndTween then
		UIStateManager.instance:push(ViewName.DomAdvCopyPinGamePlayResultView, self._curCount, self._domAdvMsg, self._domAdvParams)
	end
end

function DomAdvCopyBasePinGameTypeView:_playDelayTween(callback)
	self:_stopDelayTween()

	self._delayTween = TweenUtil.DoDelay(DomAdvCopyPinGameRootCell.SuccessTweenTime, function()
		callback()
	end)
end

function DomAdvCopyBasePinGameTypeView:_stopDelayTween()
	if self._delayTween then
		self._delayTween:Kill()

		self._delayTween = nil
	end
end

return DomAdvCopyBasePinGameTypeView
