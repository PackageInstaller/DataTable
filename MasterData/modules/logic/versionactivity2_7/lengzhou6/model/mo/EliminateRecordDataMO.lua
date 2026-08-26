-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/mo/EliminateRecordDataMO.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.mo.EliminateRecordDataMO", package.seeall)

local EliminateRecordDataMO = class("EliminateRecordDataMO")

function EliminateRecordDataMO:ctor()
	self._eliminateTypeMap = {}
end

function EliminateRecordDataMO:setEliminateType(eliminateId, eliminateType, eliminateCount, spEliminateCount)
	if self._eliminateTypeMap[eliminateId] == nil then
		self._eliminateTypeMap[eliminateId] = {}
	end

	local data = {
		eliminateType = eliminateType,
		eliminateCount = eliminateCount,
		spEliminateCount = spEliminateCount
	}

	table.insert(self._eliminateTypeMap[eliminateId], data)
end

function EliminateRecordDataMO:getEliminateTypeMap()
	return self._eliminateTypeMap
end

function EliminateRecordDataMO:clearRecord()
	tabletool.clear(self._eliminateTypeMap)
end

return EliminateRecordDataMO
