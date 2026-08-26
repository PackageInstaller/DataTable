-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepToast.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepToast", package.seeall)

local Va3ChessStepToast = class("Va3ChessStepToast", Va3ChessStepBase)

function Va3ChessStepToast:start()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameToastUpdate, self.originData.tipsId)
	TaskDispatcher.cancelTask(self._onDelayFinish, self)
	TaskDispatcher.runDelay(self._onDelayFinish, self, 0.2)
end

function Va3ChessStepToast:_onDelayFinish()
	self:finish()
end

function Va3ChessStepToast:finish()
	TaskDispatcher.cancelTask(self._onDelayFinish, self)
	Va3ChessStepToast.super.finish(self)
end

function Va3ChessStepToast:dispose()
	TaskDispatcher.cancelTask(self._onDelayFinish, self)
	Va3ChessStepToast.super.dispose(self)
end

return Va3ChessStepToast
