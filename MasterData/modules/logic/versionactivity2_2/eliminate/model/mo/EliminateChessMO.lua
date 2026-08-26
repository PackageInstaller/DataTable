-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/mo/EliminateChessMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.mo.EliminateChessMO", package.seeall)

local EliminateChessMO = class("EliminateChessMO")

function EliminateChessMO:ctor()
	self.x = 1
	self.y = 1
	self.startX = 1
	self.startY = 1
	self.id = -1
	self._status = EliminateEnum.ChessState.Normal
	self._chessBoardType = EliminateEnum.ChessBoardType.Normal
end

function EliminateChessMO:setXY(x, y)
	self.x = x
	self.y = y
end

function EliminateChessMO:setStartXY(x, y)
	self.startX = x
	self.startY = y
end

function EliminateChessMO:setChessId(id)
	self.id = id
end

function EliminateChessMO:setStatus(status)
	self._status = status
end

function EliminateChessMO:setChessBoardType(chessBoardType)
	self._chessBoardType = chessBoardType
end

function EliminateChessMO:getChessBoardType()
	return self._chessBoardType
end

function EliminateChessMO:getStatus()
	return self._status
end

function EliminateChessMO:getMoveTime()
	return EliminateEnum.AniTime.Drop
end

function EliminateChessMO:getInitMoveTime()
	return EliminateEnum.AniTime.InitDrop
end

function EliminateChessMO:clear()
	self.x = 1
	self.y = 1
	self.startX = 1
	self.startY = 1
	self.id = -1
	self._status = EliminateEnum.ChessState.Normal
	self._chessBoardType = EliminateEnum.ChessBoardType.Normal
end

return EliminateChessMO
