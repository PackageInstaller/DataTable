-- chunkname: @modules/logic/chessgame/game/interact/ChessInteractObstacle.lua

module("modules.logic.chessgame.game.interact.ChessInteractObstacle", package.seeall)

local ChessInteractObstacle = class("ChessInteractObstacle", ChessInteractBase)

function ChessInteractObstacle:playBreakAnim(callback, callbackObj)
	logNormal("on playBreakAnim....")

	if callback and callbackObj then
		self:showDestoryAni(callback, callbackObj)
	else
		self.showDestoryAni(self, self.destroy, self)
	end
end

function ChessInteractObstacle:destroy()
	if self._target.mo:isInCurrentMap() then
		ChessGameController.instance:deleteInteractObj(self._target.mo.id)
	end
end

function ChessInteractObstacle:withCatch()
	if self._target.chessEffectObj and self._target.chessEffectObj:getIsLoadEffect() then
		self._target.chessEffectObj:hideEffect()
	end
end

return ChessInteractObstacle
