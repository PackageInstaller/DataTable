-- chunkname: @modules/logic/chessgame/game/step/ChessStepPass.lua

module("modules.logic.chessgame.game.step.ChessStepPass", package.seeall)

local ChessStepPass = class("ChessStepPass", BaseWork)

function ChessStepPass:init(stepData)
	self.originData = stepData
end

function ChessStepPass:onStart()
	self:processSelectObj()
	self:onWin()
end

function ChessStepPass:processSelectObj()
	ChessGameController.instance:setSelectObj(nil)
end

function ChessStepPass:onWin()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.OnVictory)
	ChessGameController.instance:gameWin()
	self:onDone(true)
end

return ChessStepPass
