-- chunkname: @modules/logic/chessgame/game/step/ChessStepShowInteract.lua

module("modules.logic.chessgame.game.step.ChessStepShowInteract", package.seeall)

local ChessStepShowInteract = class("ChessStepShowInteract", BaseWork)

function ChessStepShowInteract:init(stepData)
	self.originData = stepData
end

function ChessStepShowInteract:onStart()
	self:appearInteract()
	self:onDone(true)
end

function ChessStepShowInteract:appearInteract()
	local mo = self.originData.interact

	mo.mapIndex = mo.mapIndex + 1

	if mo.mapIndex == ChessGameModel.instance:getNowMapIndex() then
		ChessGameController.instance:addInteractObj(mo)
	end
end

return ChessStepShowInteract
