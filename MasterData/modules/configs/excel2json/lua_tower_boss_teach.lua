-- chunkname: @modules/configs/excel2json/lua_tower_boss_teach.lua

module("modules.configs.excel2json.lua_tower_boss_teach", package.seeall)

local lua_tower_boss_teach = {}
local fields = {
	episodeId = 3,
	name = 6,
	desc = 7,
	teachId = 2,
	firstBonus = 4,
	planId = 5,
	towerId = 1
}
local primaryKey = {
	"towerId",
	"teachId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_tower_boss_teach.onLoad(json)
	lua_tower_boss_teach.configList, lua_tower_boss_teach.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_boss_teach
