-- chunkname: @modules/configs/excel2json/lua_lucky_bag_heroes.lua

module("modules.configs.excel2json.lua_lucky_bag_heroes", package.seeall)

local lua_lucky_bag_heroes = {}
local fields = {
	heroChoices = 3,
	name = 4,
	nameEn = 5,
	sceneIcon = 7,
	icon = 6,
	bagId = 2,
	poolId = 1
}
local primaryKey = {
	"poolId",
	"bagId"
}
local mlStringKey = {
	name = 1
}

function lua_lucky_bag_heroes.onLoad(json)
	lua_lucky_bag_heroes.configList, lua_lucky_bag_heroes.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_lucky_bag_heroes
