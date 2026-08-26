-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepGameFinish.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepGameFinish", package.seeall)

local Va3ChessStepGameFinish = class("Va3ChessStepGameFinish", Va3ChessStepBase)

function Va3ChessStepGameFinish:start()
	self:processSelectObj()
	self:processWinStatus()
end

function Va3ChessStepGameFinish:processSelectObj()
	Va3ChessGameController.instance:setSelectObj(nil)
end

function Va3ChessStepGameFinish:processWinStatus()
	Va3ChessGameModel.instance:setFailReason(self.originData.failReason)

	if self.originData.win == true then
		logNormal("game clear!")
		Va3ChessGameController.instance:gameClear()
	else
		self:_gameOver()
	end
end

function Va3ChessStepGameFinish:_gameOver()
	Va3ChessGameController.instance:gameOver()
end

return Va3ChessStepGameFinish
