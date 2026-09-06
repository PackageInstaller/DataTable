-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/domadvcopy/DomAdvCopyPinGamePlayView.lua

module("logic.extensions.pingame.domadvcopy.DomAdvCopyPinGamePlayView", package.seeall)

local DomAdvCopyPinGamePlayView = class("DomAdvCopyPinGamePlayView", ViewComponent)

function DomAdvCopyPinGamePlayView:ctor()
	DomAdvCopyPinGamePlayView.super.ctor(self)
end

function DomAdvCopyPinGamePlayView:buildUI()
	DomAdvCopyPinGamePlayView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._btnTip = self:getBtn("btnTip")
	self._gameContainer = self:getGo("gameContainer")
end

function DomAdvCopyPinGamePlayView:bindEvents()
	DomAdvCopyPinGamePlayView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
end

function DomAdvCopyPinGamePlayView:unbindEvents()
	DomAdvCopyPinGamePlayView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
end

function DomAdvCopyPinGamePlayView:onEnter()
	DomAdvCopyPinGamePlayView.super.onEnter(self)
	PinGameController.instance:registerLocalNotify(PinGameController.ReadyGoEvent, self._onReadyGo, self)
	PinGameController.instance:registerLocalNotify(PinGameController.CloseGameView, self._onCloseGameView, self)

	local params = self:getOpenParam()

	self._stagePlanId = params[1]
	self._stageId = params[2]
	self._domAdvParams = params[3]

	printInfo("===??? DomAdvCopyPinGamePlayView:onEnter", self._stagePlanId, self._stageId)
	self:_initView()

	local stageCfg = PinGameConfig.instance:getStageParam(self._stagePlanId, self._stageId)
	local stageData = stageCfg[1]
	local mode = stageData.mode

	if mode == 1 then
		self:showTabAt(self._gameContainer, ViewName.DomAdvCopyPinGameTypeOneView, self._stagePlanId, self._stageId, mode, self._domAdvParams)
	elseif mode == 2 then
		self:showTabAt(self._gameContainer, ViewName.DomAdvCopyPinGameTypeTwoView, self._stagePlanId, self._stageId, mode, self._domAdvParams)
	elseif mode == 3 then
		self:showTabAt(self._gameContainer, ViewName.DomAdvCopyPinGameTypeThreeView, self._stagePlanId, self._stageId, mode, self._domAdvParams)
	else
		printError("超出转盘数量限制")
	end
end

function DomAdvCopyPinGamePlayView:onExit()
	DomAdvCopyPinGamePlayView.super.onExit(self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.ReadyGoEvent, self._onReadyGo, self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.CloseGameView, self._onCloseGameView, self)
end

function DomAdvCopyPinGamePlayView:_onClickClose()
	if not self._isStarted then
		PinGameController.instance:localNotify(PinGameController.CloseGameView, PinGameController.CloseEnum_RuningExit)
		self:close()
	else
		local text = "是否确定退出游戏？"

		local function okFunc()
			PinGameController.instance:localNotify(PinGameController.CloseGameView, PinGameController.CloseEnum_RuningExit)
			self:close()
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	end
end

function DomAdvCopyPinGamePlayView:_onCloseGameView(closeEnum)
	PinGameController.instance:localNotify(PinGameController.ClickExitEvent)
	self:close()
end

function DomAdvCopyPinGamePlayView:_onClickStart()
	if self._isCanStart then
		GameUtil.SetActive(self._btnStart, false)

		self._isStarted = true

		PinGameController.instance:localNotify(PinGameController.StartGameEvent)
	end
end

function DomAdvCopyPinGamePlayView:_onReadyGo()
	printInfo("test DomAdvCopyPinGamePlayView:_onReadyGo")

	self._isCanStart = true
end

function DomAdvCopyPinGamePlayView:_initView()
	self._isCanStart = false
	self._isStarted = false

	GameUtil.SetActive(self._btnStart, true)
end

return DomAdvCopyPinGamePlayView
