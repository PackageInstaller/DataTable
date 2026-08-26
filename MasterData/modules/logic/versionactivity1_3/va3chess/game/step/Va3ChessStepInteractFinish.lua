-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepInteractFinish.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepInteractFinish", package.seeall)

local Va3ChessStepInteractFinish = class("Va3ChessStepInteractFinish", Va3ChessStepBase)

function Va3ChessStepInteractFinish:start()
	local objId = self.originData.id
	local finishedId = self.originData.finishedId

	Va3ChessGameModel.instance:addFinishInteract(objId)

	if finishedId then
		Va3ChessGameModel.instance:addAllMapFinishInteract(finishedId)
	end

	TaskDispatcher.cancelTask(self._onDelayFinish, self)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.CurrentConditionUpdate)
	TaskDispatcher.runDelay(self._onDelayFinish, self, 0.2)
end

function Va3ChessStepInteractFinish:_onDelayFinish()
	self:finish()
end

function Va3ChessStepInteractFinish:finish()
	TaskDispatcher.cancelTask(self._onDelayFinish, self)
	Va3ChessStepInteractFinish.super.finish(self)
end

function Va3ChessStepInteractFinish:dispose()
	TaskDispatcher.cancelTask(self._onDelayFinish, self)
	Va3ChessStepInteractFinish.super.dispose(self)
end

return Va3ChessStepInteractFinish
