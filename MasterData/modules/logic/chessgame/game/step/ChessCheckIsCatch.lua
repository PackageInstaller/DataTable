-- chunkname: @modules/logic/chessgame/game/step/ChessCheckIsCatch.lua

module("modules.logic.chessgame.game.step.ChessCheckIsCatch", package.seeall)

local ChessCheckIsCatch = class("ChessCheckIsCatch", BaseWork)

function ChessCheckIsCatch:init()
	return
end

function ChessCheckIsCatch:onStart(catchObj)
	self:checkIsCatchObj(catchObj)
end

function ChessCheckIsCatch:checkIsCatchObj(catchObj)
	if catchObj then
		if not ChessGameInteractModel.instance:getInteractById(catchObj.mo.id) then
			local player = ChessGameController.instance.interactsMgr:getMainPlayer()
			local x, y = player.mo:getXY()

			player:getHandler():moveTo(x, y, self.afterReturnBack, self)
		else
			ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
				visible = false
			})
			ChessGameController.instance:autoSelectPlayer()

			local player = ChessGameController.instance.interactsMgr:getMainPlayer()

			if player then
				player:getHandler():_refreshNodeArea()
				catchObj:getHandler():withCatch()
				ChessGameController.instance:setClickStatus(ChessGameEnum.SelectPosStatus.CatchObj)
				self:onDone(true)
			else
				self:onDone(true)
			end
		end
	else
		self:onDone(true)
	end
end

function ChessCheckIsCatch:afterReturnBack()
	local player = ChessGameController.instance.interactsMgr:getMainPlayer()

	player:getHandler():calCanWalkArea()

	local dir = player.mo:getDirection()

	player:getHandler():faceTo(dir)
	self:onDone(true)
end

return ChessCheckIsCatch
