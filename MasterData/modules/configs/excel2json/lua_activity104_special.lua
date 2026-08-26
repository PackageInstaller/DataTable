-- chunkname: @modules/configs/excel2json/lua_activity104_special.lua

module("modules.configs.excel2json.lua_activity104_special", package.seeall)

local lua_activity104_special = {}
local fields = {
	openDay = 9,
	name = 4,
	episodeId = 3,
	nameen = 5,
	level = 7,
	desc = 8,
	icon = 6,
	activityId = 1,
	layer = 2
}
local primaryKey = {
	"activityId",
	"layer"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity104_special.onLoad(json)
	lua_activity104_special.configList, lua_activity104_special.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity104_special
