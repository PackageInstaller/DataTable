-- chunkname: @modules/logic/chessgame/game/event/ChessStateBase.lua

module("modules.logic.chessgame.game.event.ChessStateBase", package.seeall)

local ChessStateBase = class("ChessStateBase")

function ChessStateBase:init(stateType, originData)
	self._stateType = stateType
	self.originData = originData
end

function ChessStateBase:start()
	self._stateType = nil
end

function ChessStateBase:onClickPos(x, y, manualClick)
	return
end

function ChessStateBase:getStateType()
	return self._stateType
end

function ChessStateBase:dispose()
	return
end

return ChessStateBase
