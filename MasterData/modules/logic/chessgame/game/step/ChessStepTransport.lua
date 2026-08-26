-- chunkname: @modules/logic/chessgame/game/step/ChessStepTransport.lua

module("modules.logic.chessgame.game.step.ChessStepTransport", package.seeall)

local ChessStepTransport = class("ChessStepTransport", BaseWork)

function ChessStepTransport:init(stepData)
	self.originData = stepData
end

function ChessStepTransport:onStart()
	self:_transPortMap()
end

function ChessStepTransport:_transPortMap()
	local interact = self.originData.interact
	local newMapIndex = self.originData.newMapId + 1

	if newMapIndex ~= ChessGameModel.instance:getNowMapIndex() then
		ChessGameController.instance:deleteInteractObj(interact.id)
	else
		ChessGameController.instance:addInteractObj(interact)
	end

	self:onDone(true)
end

return ChessStepTransport
