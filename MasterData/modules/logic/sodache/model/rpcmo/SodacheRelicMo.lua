-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheRelicMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheRelicMo", package.seeall)

local SodacheRelicMo = pureTable("SodacheRelicMo")

function SodacheRelicMo:init(data)
	self.id = data.id
	self.level = data.level
	self.maxLevel = #lua_sodache_upgrade.configDict[self.id]
	self.itemCo = lua_sodache_card.configDict[self.id]

	if not self.itemCo then
		logError(string.format("道具表不存在遗物ID：%s", self.id))
	end

	self.relicCo = lua_sodache_upgrade.configDict[self.id][math.max(1, self.level)]
end

function SodacheRelicMo:update(data)
	self.level = data.level
	self.relicCo = lua_sodache_upgrade.configDict[self.id][math.max(1, self.level)]
end

return SodacheRelicMo
