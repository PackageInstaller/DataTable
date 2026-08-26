-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/event/Va3ChessStateLock.lua

module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateLock", package.seeall)

local Va3ChessStateLock = class("Va3ChessStateLock", Va3ChessStateBase)

function Va3ChessStateLock:start()
	logNormal("Va3ChessStateLock start")
end

function Va3ChessStateLock:onClickPos(x, y)
	return
end

return Va3ChessStateLock
