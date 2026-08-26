-- chunkname: @modules/configs/excel2json/lua_activity191_init_build.lua

module("modules.configs.excel2json.lua_activity191_init_build", package.seeall)

local lua_activity191_init_build = {}
local fields = {
	name = 3,
	randHero = 8,
	item = 7,
	rewardHero = 10,
	randItem = 9,
	hero = 6,
	rewardItem = 11,
	desc = 4,
	style = 2,
	coin = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"style"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity191_init_build.onLoad(json)
	lua_activity191_init_build.configList, lua_activity191_init_build.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_init_build
