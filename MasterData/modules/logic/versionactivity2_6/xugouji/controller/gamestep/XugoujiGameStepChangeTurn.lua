-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepChangeTurn.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepChangeTurn", package.seeall)

local XugoujiGameStepChangeTurn = class("XugoujiGameStepChangeTurn", XugoujiGameStepBase)
local actId = VersionActivity2_6Enum.ActivityId.Xugouji
local changeIntervalConstId = 2
local flipWaitTimeConstId = 3

function XugoujiGameStepChangeTurn:start()
	local isSelf = self._stepData.isSelf

	Activity188Model.instance:setTurn(isSelf)
	Activity188Model.instance:setCurCardUid(nil)

	local isDoingXugoujiGuide = Activity188Model.instance:isGameGuideMode()

	if not isDoingXugoujiGuide then
		local cardInfoList = Activity188Model.instance:getCardsInfoList()
		local hasUnActiveCardFront = false

		for _, cardInfo in ipairs(cardInfoList) do
			local uid = cardInfo.uid

			if Activity188Model.instance:getCardItemStatue(uid) == XugoujiEnum.CardStatus.Front then
				hasUnActiveCardFront = true

				break
			end
		end

		if hasUnActiveCardFront then
			local flipBackWaitTime = tonumber(Activity188Config.instance:getConstCfg(actId, flipWaitTimeConstId).value2)

			TaskDispatcher.runDelay(self._doChangeTurnAction, self, flipBackWaitTime or 2)
		else
			local changeTurnWaitTime = tonumber(Activity188Config.instance:getConstCfg(actId, changeIntervalConstId).value2)

			TaskDispatcher.runDelay(self._doChangeTurnCardsView, self, changeTurnWaitTime or 2)
		end
	else
		XugoujiController.instance:registerCallback(XugoujiEvent.GuideChangeTurn, self._onGuideChangeTurn, self)
	end
end

function XugoujiGameStepChangeTurn:_onGuideChangeTurn()
	self:_doChangeTurnAction()
end

function XugoujiGameStepChangeTurn:_doChangeTurnAction()
	self:_filpBackUnActiveCards()

	local changeTurnWaitTime = tonumber(Activity188Config.instance:getConstCfg(actId, changeIntervalConstId).value2)

	TaskDispatcher.runDelay(self._doChangeTurnCardsView, self, changeTurnWaitTime or 2)
end

function XugoujiGameStepChangeTurn:_filpBackUnActiveCards()
	XugoujiController.instance:dispatchEvent(XugoujiEvent.FilpBackUnActiveCard)
end

function XugoujiGameStepChangeTurn:_doChangeTurnCardsView()
	local isMyTurn = Activity188Model.instance:isMyTurn()

	if isMyTurn then
		Activity188Model.instance:setGameViewState(XugoujiEnum.GameViewState.PlayerOperating)
	else
		Activity188Model.instance:setGameViewState(XugoujiEnum.GameViewState.EnemyOperating)
	end

	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.changeTurn)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.TurnChanged, isMyTurn and 1 or 0)

	local changeTurnDelay = tonumber(Activity188Config.instance:getConstCfg(actId, changeIntervalConstId).value2)

	TaskDispatcher.runDelay(self.finish, self, 1)
end

function XugoujiGameStepChangeTurn:finish()
	XugoujiGameStepChangeTurn.super.finish(self)
end

function XugoujiGameStepChangeTurn:dispose()
	XugoujiController.instance:unregisterCallback(XugoujiEvent.GuideChangeTurn, self._onGuideChangeTurn, self)
	TaskDispatcher.cancelTask(self._doChangeTurnAction, self)
	TaskDispatcher.cancelTask(self.finish, self)
	XugoujiGameStepBase.dispose(self)
end

return XugoujiGameStepChangeTurn
