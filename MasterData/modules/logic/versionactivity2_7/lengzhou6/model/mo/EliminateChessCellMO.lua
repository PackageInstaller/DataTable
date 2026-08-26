-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/mo/EliminateChessCellMO.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.mo.EliminateChessCellMO", package.seeall)

local EliminateChessCellMO = class("EliminateChessCellMO", EliminateChessMO)

function EliminateChessCellMO:ctor()
	EliminateChessCellMO.super.ctor(self)

	self._status = {}
end

function EliminateChessCellMO:setChessId(id)
	EliminateChessCellMO.super.setChessId(self, id)
	self:setEliminateID()
end

function EliminateChessCellMO:setEliminateID()
	self._eliminateID = EliminateEnum_2_7.ChessIndexToType[self.id] or ""
end

function EliminateChessCellMO:canMove()
	return self:haveStatus(EliminateEnum.ChessState.Frost)
end

function EliminateChessCellMO:getEliminateID()
	if self._eliminateID == nil then
		logNormal("EliminateChessCellMO:getEliminateID() self._eliminateID == nil")
	end

	return self._eliminateID
end

function EliminateChessCellMO:setStatus(status)
	if status == EliminateEnum.ChessState.Normal or status == EliminateEnum.ChessState.Die then
		tabletool.clear(self._status)
	end

	self:addStatus(status)
end

function EliminateChessCellMO:haveStatus(status)
	for i = 1, #self._status do
		local s = self._status[i]

		if s == status then
			return true
		end
	end

	return false
end

function EliminateChessCellMO:addStatus(status)
	if status == EliminateEnum.ChessState.Normal or status == EliminateEnum.ChessState.Die then
		tabletool.clear(self._status)
	end

	if not self:haveStatus(status) then
		table.insert(self._status, status)
	end
end

function EliminateChessCellMO:unsetStatus(status)
	for i = 1, #self._status do
		local s = self._status[i]

		if s == status then
			table.remove(self._status, i)

			break
		end
	end
end

function EliminateChessCellMO:clear()
	if self._status then
		tabletool.clear(self._status)
	end

	EliminateChessCellMO.super.clear(self)
end

return EliminateChessCellMO
