-- chunkname: @modules/logic/chessgame/game/step/ChessStepChangeModule.lua

module("modules.logic.chessgame.game.step.ChessStepChangeModule", package.seeall)

local ChessStepChangeModule = class("ChessStepChangeModule", BaseWork)

function ChessStepChangeModule:init(stepData)
	self.originData = stepData
end

function ChessStepChangeModule:onStart()
	local id = self.originData.interactId
	local path = self.originData.path
	local comp = ChessGameController.instance.interactsMgr:get(id)
	local mo = ChessGameInteractModel.instance:getInteractById(id)

	if mo and mo:isInCurrentMap() then
		comp:changeModule(path)
	end

	self:onDone(true)
end

return ChessStepChangeModule
