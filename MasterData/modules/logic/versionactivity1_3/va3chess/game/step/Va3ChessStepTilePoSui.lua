-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepTilePoSui.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepTilePoSui", package.seeall)

local Va3ChessStepTilePoSui = class("Va3ChessStepTilePoSui", Va3ChessStepBase)

function Va3ChessStepTilePoSui:start()
	self:processNextTileStatus()
end

function Va3ChessStepTilePoSui:processNextTileStatus()
	local tileMO = Va3ChessGameModel.instance:getTileMO(self.originData.x, self.originData.y)

	if tileMO and tileMO:isHasTrigger(Va3ChessEnum.TileTrigger.PoSui) then
		tileMO:addFinishTrigger(Va3ChessEnum.TileTrigger.PoSui)
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.TilePosuiTrigger, self.originData.x, self.originData.y)
		TaskDispatcher.cancelTask(self._onDelayFinish, self)
		TaskDispatcher.runDelay(self._onDelayFinish, self, 0.2)
	else
		self:_onDelayFinish()
	end
end

function Va3ChessStepTilePoSui:_onDelayFinish()
	self:finish()
end

function Va3ChessStepTilePoSui:finish()
	TaskDispatcher.cancelTask(self._onDelayFinish, self)
	Va3ChessStepTilePoSui.super.finish(self)
end

function Va3ChessStepTilePoSui:dispose()
	TaskDispatcher.cancelTask(self._onDelayFinish, self)
	Va3ChessStepTilePoSui.super.dispose(self)
end

return Va3ChessStepTilePoSui
