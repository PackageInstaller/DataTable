-- chunkname: @modules/logic/chessgame/game/step/ChessStepCompleted.lua

module("modules.logic.chessgame.game.step.ChessStepCompleted", package.seeall)

local ChessStepCompleted = class("ChessStepCompleted", BaseWork)

function ChessStepCompleted:init(stepData)
	self.originData = stepData
end

function ChessStepCompleted:onStart()
	local interactMo = ChessGameInteractModel.instance:getInteractById(self.originData.interactId)

	if interactMo then
		interactMo.isFinish = true

		local player = ChessGameController.instance.interactsMgr:getMainPlayer()

		player:getHandler():calCanWalkArea()
		ChessGameInteractModel.instance:setInteractFinishMap()
	end

	self:onDone(true)
end

return ChessStepCompleted
