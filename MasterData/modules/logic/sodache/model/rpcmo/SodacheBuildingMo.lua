-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheBuildingMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheBuildingMo", package.seeall)

local SodacheBuildingMo = pureTable("SodacheBuildingMo")

function SodacheBuildingMo:init(data)
	self.type = data.type
	self.level = data.level
	self.baseCo = lua_sodache_building.configDict[self.type][1]
	self.co = lua_sodache_building.configDict[self.type][self.level]
	self.maxLevel = #lua_sodache_building.configDict[self.type] or 1
end

function SodacheBuildingMo:update(level)
	self.level = level
	self.co = lua_sodache_building.configDict[self.type][self.level]
end

return SodacheBuildingMo
