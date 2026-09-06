-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickapet/view/PickCoutDownView.lua

module("logic.extensions.pickapet.view.PickCoutDownView", package.seeall)

local PickCoutDownView = class("PickCoutDownView", ViewComponent)

function PickCoutDownView:ctor()
	PickCoutDownView.super.ctor(self)

	self._count = 3
	self._onPause = false
end

function PickCoutDownView:bindEvents()
	GlobalDispatcher:addListener(GlobalNotify.PickCountDown, self._onStartCountDown, self)
	GlobalDispatcher:addListener(GlobalNotify.PickStartGame, self._onDealCountDown, self)
	GlobalDispatcher:addListener(GlobalNotify.PickPause, self._onPauseCountDown, self)
	GlobalDispatcher:addListener(GlobalNotify.PickLevelEnd, self._onLevelEnd, self)
	self._Btn_start:AddClickListener(self.onBtnStartFunc, self)
end

function PickCoutDownView:unbindEvents()
	GlobalDispatcher:removeListener(GlobalNotify.PickCountDown, self._onStartCountDown, self)
	GlobalDispatcher:removeListener(GlobalNotify.PickStartGame, self._onDealCountDown, self)
	GlobalDispatcher:removeListener(GlobalNotify.PickPause, self._onPauseCountDown, self)
	GlobalDispatcher:removeListener(GlobalNotify.PickLevelEnd, self._onLevelEnd, self)
	self._Btn_start:RemoveClickListener()
end

function PickCoutDownView:buildUI()
	self._CountDown = self:getGo("CountDown"):GetComponent("UIImageSpriteChange")

	self._CountDown.gameObject:SetActive(false)

	self._Txt_time = self:getGo("Game_Info/Txt_time"):GetComponent("Text")
	self._Pnl_start = self:getGo("Pnl_start")
	self._Game_Info = self:getGo("Game_Info")
	self._Btn_start = self:getBtn("Pnl_start/Btn_start")
end

function PickCoutDownView:destroyUI()
	return
end

function PickCoutDownView:onEnter()
	self._gameType = PickAPetModel.instance:getGameType()

	PickAPetModel.instance:initGateInfo()
	self._Pnl_start.gameObject:SetActive(true)
	self._Game_Info.gameObject:SetActive(false)
end

function PickCoutDownView:_onStartCountDown()
	self._CountDown.gameObject:SetActive(true)

	self._count = 3

	local count = math.min(3, self._count)

	count = math.max(0, self._count)

	self._CountDown:SetState(self._count)
	settimer(1, self._startCoutDown, self)
end

function PickCoutDownView:_onDealCountDown()
	self._count = PickAPetModel.instance:getLevelCfg().time

	removetimer(self._DealCountDown, self)

	self._Txt_time.text = string.format("剩余时间：<color=#206c57>%d</color>秒", PickAPetModel.instance:getDealCountTime())

	settimer(1, self._DealCountDown, self)
end

function PickCoutDownView:onEnterFinished()
	return
end

function PickCoutDownView:onExit()
	removetimer(self._DealCountDown, self)

	self._onPause = false
end

function PickCoutDownView:onExitFinished()
	return
end

function PickCoutDownView:_startCoutDown()
	self._count = self._count - 1

	local count = math.min(3, self._count)

	self._CountDown:SetState((math.max(0, self._count)))

	if self._count == -1 then
		removetimer(self._startCoutDown, self)
		self._CountDown.gameObject:SetActive(false)
		PickAPetController.instance:startGame()
	end
end

function PickCoutDownView:_DealCountDown()
	if self._onPause then
		return nil
	end

	PickAPetModel.instance:setDealCountTime(PickAPetModel.instance:getDealCountTime() - 1)

	self._Txt_time.text = string.format("剩余时间：<color=#206c57>%d</color>秒", PickAPetModel.instance:getDealCountTime())

	if PickAPetModel.instance:getDealCountTime() <= 0 then
		PickAPetController.instance:endGame(true, GameUtil.handler(self.close, self))
		removetimer(self._DealCountDown, self)
	end
end

function PickCoutDownView:_onPauseCountDown(pause)
	self._onPause = pause
end

function PickCoutDownView:_onLevelEnd()
	removetimer(self._DealCountDown, self)
end

function PickCoutDownView:onBtnStartFunc()
	if self._gameType == PickAPetModel.GameType.QianNiaoZhenShen then
		self:_deductGameTimes()
	end

	self._Pnl_start.gameObject:SetActive(false)
	self:_onStartCountDown()
end

function PickCoutDownView:_deductGameTimes()
	local reqExtParams = "{\"starGame\":\"true\"}"

	ChallengeController.instance:extTeamOpt(ChallengeModel.instance:getCurId(), 3, "17_Accumulate", reqExtParams, nil)
end

return PickCoutDownView
