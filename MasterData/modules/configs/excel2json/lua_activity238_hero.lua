-- chunkname: @modules/configs/excel2json/lua_activity238_hero.lua

module("modules.configs.excel2json.lua_activity238_hero", package.seeall)

local lua_activity238_hero = {}
local fields = {
	name = 4,
	index = 2,
	headIcon = 3,
	activityId = 1,
	desc = 5
}
local primaryKey = {
	"activityId",
	"index"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity238_hero.onLoad(json)
	lua_activity238_hero.configList, lua_activity238_hero.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity238_hero
