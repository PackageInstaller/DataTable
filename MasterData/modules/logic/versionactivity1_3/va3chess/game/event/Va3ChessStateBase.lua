-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/event/Va3ChessStateBase.lua

module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateBase", package.seeall)

local Va3ChessStateBase = class("Va3ChessStateBase")

function Va3ChessStateBase:init(stateType, originData)
	self._stateType = stateType
	self.originData = originData
end

function Va3ChessStateBase:start()
	self._stateType = nil
end

function Va3ChessStateBase:onClickPos(x, y, manualClick)
	return
end

function Va3ChessStateBase:getStateType()
	return self._stateType
end

function Va3ChessStateBase:dispose()
	return
end

return Va3ChessStateBase
