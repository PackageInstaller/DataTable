-- chunkname: @modules/configs/excel2json/lua_activity191_summon.lua

module("modules.configs.excel2json.lua_activity191_summon", package.seeall)

local lua_activity191_summon = {}
local fields = {
	monsterId = 6,
	name = 4,
	priority = 2,
	relation = 9,
	headIcon = 7,
	career = 5,
	summonType = 3,
	id = 1,
	icon = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity191_summon.onLoad(json)
	lua_activity191_summon.configList, lua_activity191_summon.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_summon
