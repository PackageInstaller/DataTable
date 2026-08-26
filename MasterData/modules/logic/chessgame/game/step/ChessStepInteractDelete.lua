-- chunkname: @modules/logic/chessgame/game/step/ChessStepInteractDelete.lua

module("modules.logic.chessgame.game.step.ChessStepInteractDelete", package.seeall)

local ChessStepInteractDelete = class("ChessStepInteractDelete", BaseWork)

function ChessStepInteractDelete:init(stepData)
	self.originData = stepData
end

function ChessStepInteractDelete:onStart()
	self:deleteInteractObj()
end

function ChessStepInteractDelete:deleteInteractObj()
	local objId = self.originData.id
	local mo = ChessGameInteractModel.instance:getInteractById(objId)

	if mo and mo:isInCurrentMap() then
		local comp = ChessGameController.instance.interactsMgr:get(objId)

		comp:getHandler():showDestoryAni(self._deleteAnimCallback, self)
	else
		self:_deleteAnimCallback()
	end
end

function ChessStepInteractDelete:_deleteAnimCallback()
	local objId = self.originData.id

	ChessGameController.instance:deleteInteractObj(objId)
	self:onDone(true)
end

return ChessStepInteractDelete
