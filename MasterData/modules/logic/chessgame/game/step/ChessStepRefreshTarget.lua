-- chunkname: @modules/logic/chessgame/game/step/ChessStepRefreshTarget.lua

module("modules.logic.chessgame.game.step.ChessStepRefreshTarget", package.seeall)

local ChessStepRefreshTarget = class("ChessStepRefreshTarget", BaseWork)

function ChessStepRefreshTarget:init(stepData)
	self.originData = stepData
end

function ChessStepRefreshTarget:onStart()
	ChessGameModel.instance:setCompletedCount(self.originData.completedCount)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.CurrentConditionUpdate)
	self:onDone(true)
end

return ChessStepRefreshTarget
