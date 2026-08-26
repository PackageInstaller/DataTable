-- chunkname: @modules/configs/excel2json/lua_activity_nuodika_180_enemy.lua

module("modules.configs.excel2json.lua_activity_nuodika_180_enemy", package.seeall)

local lua_activity_nuodika_180_enemy = {}
local fields = {
	enemyId = 1,
	name = 2,
	eventID = 10,
	main = 6,
	mapID = 11,
	picture = 4,
	desc = 3,
	skillID = 9,
	hp = 7,
	atk = 8,
	pictureOffset = 5
}
local primaryKey = {
	"enemyId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity_nuodika_180_enemy.onLoad(json)
	lua_activity_nuodika_180_enemy.configList, lua_activity_nuodika_180_enemy.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity_nuodika_180_enemy
