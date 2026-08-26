-- chunkname: @modules/logic/chessgame/game/step/ChessStepDead.lua

module("modules.logic.chessgame.game.step.ChessStepDead", package.seeall)

local ChessStepDead = class("ChessStepDead", BaseWork)

function ChessStepDead:init(stepData)
	self.originData = stepData
end

function ChessStepDead:onStart()
	self:_onFail()
end

function ChessStepDead:_onFail()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.OnFail)
	ChessGameController.instance:gameOver()
	self:onDone(true)
end

return ChessStepDead
