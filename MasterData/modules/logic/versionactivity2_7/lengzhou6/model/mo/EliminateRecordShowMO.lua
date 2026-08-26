-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/mo/EliminateRecordShowMO.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.mo.EliminateRecordShowMO", package.seeall)

local EliminateRecordShowMO = class("EliminateRecordShowMO")

function EliminateRecordShowMO:ctor()
	self._eliminateList = {}
	self._changeTypeList = {}
	self._moveList = {}
	self._newList = {}
end

function EliminateRecordShowMO:getEliminate()
	return self._eliminateList
end

function EliminateRecordShowMO:getChangeType()
	return self._changeTypeList
end

function EliminateRecordShowMO:getMove()
	return self._moveList
end

function EliminateRecordShowMO:getNew()
	return self._newList
end

function EliminateRecordShowMO:addEliminate(x, y, skillType)
	table.insert(self._eliminateList, x)
	table.insert(self._eliminateList, y)
	table.insert(self._eliminateList, skillType)
end

function EliminateRecordShowMO:addChangeType(x, y, type)
	table.insert(self._changeTypeList, x)
	table.insert(self._changeTypeList, y)
	table.insert(self._changeTypeList, type)
end

function EliminateRecordShowMO:addMove(fromX, fromY, toX, toY)
	table.insert(self._moveList, fromX)
	table.insert(self._moveList, fromY)
	table.insert(self._moveList, toX)
	table.insert(self._moveList, toY)
end

function EliminateRecordShowMO:addNew(x, y)
	table.insert(self._newList, x)
	table.insert(self._newList, y)
end

function EliminateRecordShowMO:reset()
	tabletool.clear(self._eliminateList)
	tabletool.clear(self._changeTypeList)
	tabletool.clear(self._moveList)
	tabletool.clear(self._newList)
end

return EliminateRecordShowMO
