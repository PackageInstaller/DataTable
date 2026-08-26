-- chunkname: @modules/configs/excel2json/lua_activity174_season.lua

module("modules.configs.excel2json.lua_activity174_season", package.seeall)

local lua_activity174_season = {}
local fields = {
	openTime = 3,
	name = 4,
	season = 1,
	activityId = 2,
	desc = 5
}
local primaryKey = {
	"season"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity174_season.onLoad(json)
	lua_activity174_season.configList, lua_activity174_season.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_season
