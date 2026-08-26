-- chunkname: @modules/configs/excel2json/lua_activity191_enhance.lua

module("modules.configs.excel2json.lua_activity191_enhance", package.seeall)

local lua_activity191_enhance = {}
local fields = {
	relate = 8,
	name = 4,
	relateItem = 7,
	icon = 9,
	weight = 11,
	desc = 5,
	effects = 10,
	relateHero = 6,
	id = 1,
	stage = 3,
	activityId = 2
}
local primaryKey = {
	"id",
	"activityId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity191_enhance.onLoad(json)
	lua_activity191_enhance.configList, lua_activity191_enhance.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_enhance
