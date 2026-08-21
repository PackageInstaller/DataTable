-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkKillMO.lua

module("logic.extensions.airworkshop.model.def.AirWorkKillMO", package.seeall)

local M = class("AirWorkKillMO")

function M:ctor()
	self._deathCount = 0
	self._unionIndex = 0
	self._record = false
end

function M:initByAgent(unitNO)
	self._deathCount = unitNO.deadCount
	self._unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unitNO.cell.x, unitNO.cell.z)
	self._record = {}

	for i, v in ipairs(unitNO.record) do
		local data = {}

		data.heroId = v.heroId
		data.target = {}
		data.target.heroId = v.target.heroId
		data.target.count = v.target.count

		table.insert(self._record, data)
	end
end

function M:getUnionIndex()
	return self._unionIndex or -1
end

function M:getUnitType()
	return AirWorkShopEnum.UnitType.KillData
end

function M:getCount()
	return self._deathCount
end

function M:getRecord()
	return self._record
end

function M:getPosition()
	return BoardIndexConverter.unionIndexToCoordinates(self._unionIndex)
end

return M
