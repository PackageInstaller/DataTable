-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/model/DoushouqiCellMo.lua

module("logic.extensions.doushouqi.model.DoushouqiCellMo", package.seeall)

local DoushouqiCellMo = class("DoushouqiCellMo")

function DoushouqiCellMo:ctor()
	self:_initParams()
end

function DoushouqiCellMo:_initParams()
	self._level = 0
	self._id = 0
	self._row = 0
	self._col = 0
	self._isEmpty = false
	self._isUnlock = false
	self._sideId = 0
	self._chess = {}
	self._pointId = -1
end

function DoushouqiCellMo:setData(data)
	self._data = data
end

function DoushouqiCellMo:setChess(chess)
	self._chess = chess
	self._states = {}
	self._knowStr = ""

	if chess then
		self._isEmpty = false
		self._sideId = math.floor(chess.chessType / 100)
		self._isUnlock = chess.chessType > 0
		self._level = chess.chessType % 100
		self._pointId = chess.pointId
		self._states = chess.state

		for i, v in ipairs(chess.state) do
			if string.find(v, "know#") then
				self._knowStr = v
			end
		end
	else
		self._isEmpty = true
		self._isUnlock = false
		self._level = 0
	end
end

function DoushouqiCellMo:getChess()
	return self._chess
end

function DoushouqiCellMo:setRowCol(row, col)
	self._row = row
	self._col = col
end

function DoushouqiCellMo:getRow()
	return self._row
end

function DoushouqiCellMo:getCol()
	return self._col
end

function DoushouqiCellMo:isUnlock()
	return self._isUnlock
end

function DoushouqiCellMo:isEmpty()
	return self._isEmpty
end

function DoushouqiCellMo:setEmpty()
	self._isEmpty = true
end

function DoushouqiCellMo:getLevel()
	return self._level
end

function DoushouqiCellMo:destroy()
	return
end

function DoushouqiCellMo:getSideId()
	return self._sideId
end

function DoushouqiCellMo:getPointId()
	return self._pointId
end

function DoushouqiCellMo:isStrikeVertigo()
	return table.indexof(self._states, "strike_vertigo")
end

function DoushouqiCellMo:isStrike()
	return table.indexof(self._states, "strike")
end

function DoushouqiCellMo:isBlock()
	return table.indexof(self._states, "block")
end

function DoushouqiCellMo:isKnow()
	if self:isUnlock() or self:isEmpty() then
		return false
	end

	return not string.nilorempty(self._knowStr)
end

function DoushouqiCellMo:isInvisibility()
	return table.indexof(self._states, "invisibility")
end

function DoushouqiCellMo:isCounterAttack()
	return table.indexof(self._states, "counterAttack_lock")
end

function DoushouqiCellMo:getKonwLevel()
	local arr = string.split(self._knowStr, "#")

	return checknumber(arr[2]) % 100
end

function DoushouqiCellMo:getKnowSideId()
	local arr = string.split(self._knowStr, "#")

	return math.floor(checknumber(arr[2]) / 100)
end

function DoushouqiCellMo:setPointId(pointId)
	self._pointId = pointId
end

return DoushouqiCellMo
