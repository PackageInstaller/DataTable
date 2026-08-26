-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepTargetUpdate.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepTargetUpdate", package.seeall)

local Va3ChessStepTargetUpdate = class("Va3ChessStepTargetUpdate", Va3ChessStepBase)

function Va3ChessStepTargetUpdate:start()
	local data = self.originData

	Va3ChessGameModel.instance:setFinishedTargetNum(data.targetNum)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.TargetUpdate)
	self:finish()
end

return Va3ChessStepTargetUpdate
