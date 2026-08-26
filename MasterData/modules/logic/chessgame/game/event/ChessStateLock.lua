-- chunkname: @modules/logic/chessgame/game/event/ChessStateLock.lua

module("modules.logic.chessgame.game.event.ChessStateLock", package.seeall)

local ChessStateLock = class("ChessStateLock", ChessStateBase)

function ChessStateLock:start()
	return
end

function ChessStateLock:onClickPos(x, y, manualClick)
	return
end

return ChessStateLock
