-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/PinGamePlayView.lua

module("logic.extensions.pingame.view.PinGamePlayView", package.seeall)

local PinGamePlayView = class("PinGamePlayView", ViewComponent)

function PinGamePlayView:ctor()
	PinGamePlayView.super.ctor(self)
end

function PinGamePlayView:buildUI()
	PinGamePlayView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._btnTip = self:getBtn("btnTip")
	self._gameContainer = self:getGo("gameContainer")
end

function PinGamePlayView:bindEvents()
	PinGamePlayView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
end

function PinGamePlayView:unbindEvents()
	PinGamePlayView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
end

function PinGamePlayView:onEnter()
	PinGamePlayView.super.onEnter(self)
	PinGameController.instance:registerLocalNotify(PinGameController.ReadyGoEvent, self._onReadyGo, self)
	PinGameController.instance:registerLocalNotify(PinGameController.CloseGameView, self._onCloseGameView, self)

	local params = self:getOpenParam()

	self._pinGameParamsMo = params[1]
	self._stagePlanId = self._pinGameParamsMo:getStagePlanId()
	self._stageId = self._pinGameParamsMo:getStageId()
	self._isLocalGame = self._pinGameParamsMo:isLocalGame()
	self._activityId = self._pinGameParamsMo:getActivityId()

	printInfo("test PinGamePlayView:onEnter", self._stagePlanId, self._stageId, self._isLocalGame, self._activityId)
	self:_initView()

	if self._stagePlanId == 1 then
		self:showTabAt(self._gameContainer, ViewName.PinGameTypeOneView, self._stagePlanId, self._stageId, self._isLocalGame, self._activityId)
	elseif self._stagePlanId == 2 then
		self:showTabAt(self._gameContainer, ViewName.PinGameTypeTwoView, self._stagePlanId, self._stageId, self._isLocalGame, self._activityId)
	elseif self._stagePlanId == 3 then
		self:showTabAt(self._gameContainer, ViewName.PinGameTypeThreeView, self._stagePlanId, self._stageId, self._isLocalGame, self._activityId)
	end
end

function PinGamePlayView:onExit()
	PinGamePlayView.super.onExit(self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.ReadyGoEvent, self._onReadyGo, self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.CloseGameView, self._onCloseGameView, self)
end

function PinGamePlayView:_onClickClose()
	local text = "是否确定退出游戏？"

	local function okFunc()
		if not self._isLocalGame then
			local isSuccess = false

			PinGameController.instance:sendPM_PinGameEndGameReq(self._activityId, self._stagePlanId, self._stageId, isSuccess)
		end

		PinGameController.instance:localNotify(PinGameController.CloseGameView, PinGameController.CloseEnum_RuningExit)
		self:close()
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function PinGamePlayView:_onCloseGameView(closeEnum)
	local callBack = self._pinGameParamsMo:getGameEndCallBack()

	GameUtil.callBack(callBack, closeEnum)
	PinGameController.instance:localNotify(PinGameController.ClickExitEvent)
	self:close()
end

function PinGamePlayView:_onClickStart()
	if self._isCanStart then
		GameUtil.SetActive(self._btnStart, false)
		PinGameController.instance:localNotify(PinGameController.StartGameEvent)
	end
end

function PinGamePlayView:_onReadyGo()
	printInfo("test PinGamePlayView:_onReadyGo")

	self._isCanStart = true
end

function PinGamePlayView:_initView()
	self._isCanStart = false

	GameUtil.SetActive(self._btnStart, true)
end

return PinGamePlayView
