-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepTileBroken.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepTileBroken", package.seeall)

local Va3ChessStepTileBroken = class("Va3ChessStepTileBroken", Va3ChessStepBase)

function Va3ChessStepTileBroken:start()
	self:processNextTileStatus()
end

function Va3ChessStepTileBroken:processNextTileStatus()
	local x, y = self.originData.x, self.originData.y
	local tileMO = Va3ChessGameModel.instance:getTileMO(x, y)
	local brokenTriggerType = Va3ChessEnum.TileTrigger.Broken

	if tileMO and tileMO:isHasTrigger(brokenTriggerType) then
		local status
		local brokenTriggerTypeStatus = Va3ChessEnum.TriggerStatus[brokenTriggerType]

		if self.originData.stepType == Va3ChessEnum.Act142StepType.TileFragile then
			status = brokenTriggerTypeStatus.Fragile
		elseif self.originData.stepType == Va3ChessEnum.Act142StepType.TileBroken then
			status = brokenTriggerTypeStatus.Broken

			tileMO:addFinishTrigger(brokenTriggerType)
		end

		tileMO:updateTrigger(brokenTriggerType, status)
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.TileTriggerUpdate, x, y, brokenTriggerType)
		TaskDispatcher.cancelTask(self._onDelayFinish, self)
		TaskDispatcher.runDelay(self._onDelayFinish, self, 0.2)
	else
		self:_onDelayFinish()
	end
end

function Va3ChessStepTileBroken:_onDelayFinish()
	self:finish()
end

function Va3ChessStepTileBroken:finish()
	TaskDispatcher.cancelTask(self._onDelayFinish, self)
	Va3ChessStepTileBroken.super.finish(self)
end

function Va3ChessStepTileBroken:dispose()
	TaskDispatcher.cancelTask(self._onDelayFinish, self)
	Va3ChessStepTileBroken.super.dispose(self)
end

return Va3ChessStepTileBroken
