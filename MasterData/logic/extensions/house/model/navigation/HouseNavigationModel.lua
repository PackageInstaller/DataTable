-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/navigation/HouseNavigationModel.lua

module("logic.extensions.house.model.navigation.HouseNavigationModel", package.seeall)

local M = class("HouseNavigationModel", BaseModel)

function M:ctor()
	self._arrayNavigationMO = {}
end

function M:onInit()
	self:_resetData()
end

function M:onReset()
	self:_resetData()
end

function M:_resetData()
	table.clear(self._arrayNavigationMO)
end

function M:addNavigationMO(mo)
	table.insert(self._arrayNavigationMO, mo)
end

function M:clearNavigationMOs()
	table.clear(self._arrayNavigationMO)
end

function M:getMOByZoneId(zoneId)
	for _, mo in ipairs(self._arrayNavigationMO) do
		if mo:getZoneId() == zoneId then
			return mo
		end
	end

	printWarn(string.format("no navmesh surface data with zoneId:%s", zoneId))
end

function M:getMOBySurfaceName(name)
	for _, mo in ipairs(self._arrayNavigationMO) do
		if mo:getSurfaceGoName() == name then
			return mo
		end
	end

	printWarn(string.format("no navmesh surface name:%s", name))
end

M.instance = M.New()

return M
