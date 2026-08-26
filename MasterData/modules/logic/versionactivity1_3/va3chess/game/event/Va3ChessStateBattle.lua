-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/event/Va3ChessStateBattle.lua

module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateBattle", package.seeall)

local Va3ChessStateBattle = class("Va3ChessStateBattle", Va3ChessStateBase)

function Va3ChessStateBattle:start()
	logNormal("Va3ChessStateBattle start")
	Va3ChessGameController.instance:registerCallback(Va3ChessEvent.GameViewOpened, self.onReturnChessFinish, self)
	self:startBattle()
end

function Va3ChessStateBattle:startBattle()
	Va3ChessController.instance:enterActivityFight(self.originData.battleId)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventFinishPlay)
end

function Va3ChessStateBattle:onReturnChessFinish(viewParam)
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.GameViewOpened, self.onReturnChessFinish, self)

	if viewParam and viewParam.fromRefuseBattle then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventBattleReturn)
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventFinishPlay, self)
end

function Va3ChessStateBattle:onReceiveAboveGame(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	logNormal("game over by refuse battle !")
	Va3ChessGameController.instance:gameOver()
end

function Va3ChessStateBattle:dispose()
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.GameViewOpened, self.onReturnChessFinish, self)
end

return Va3ChessStateBattle
