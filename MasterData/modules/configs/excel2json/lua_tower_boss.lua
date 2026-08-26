-- chunkname: @modules/configs/excel2json/lua_tower_boss.lua

module("modules.configs.excel2json.lua_tower_boss", package.seeall)

local lua_tower_boss = {}
local fields = {
	bossId = 2,
	name = 3,
	nameEn = 4,
	towerId = 1
}
local primaryKey = {
	"towerId"
}
local mlStringKey = {
	name = 1
}

function lua_tower_boss.onLoad(json)
	lua_tower_boss.configList, lua_tower_boss.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_boss
