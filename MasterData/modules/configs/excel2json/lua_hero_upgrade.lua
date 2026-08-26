-- chunkname: @modules/configs/excel2json/lua_hero_upgrade.lua

module("modules.configs.excel2json.lua_hero_upgrade", package.seeall)

local lua_hero_upgrade = {}
local fields = {
	id = 1,
	heroId = 4,
	options = 3,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_hero_upgrade.onLoad(json)
	lua_hero_upgrade.configList, lua_hero_upgrade.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_upgrade
