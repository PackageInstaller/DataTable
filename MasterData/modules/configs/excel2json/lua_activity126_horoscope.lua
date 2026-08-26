-- chunkname: @modules/configs/excel2json/lua_activity126_horoscope.lua

module("modules.configs.excel2json.lua_activity126_horoscope", package.seeall)

local lua_activity126_horoscope = {}
local fields = {
	desc = 4,
	resultIcon = 5,
	id = 1,
	activityId = 2,
	bonus = 3
}
local primaryKey = {
	"id",
	"activityId"
}
local mlStringKey = {
	desc = 1
}

function lua_activity126_horoscope.onLoad(json)
	lua_activity126_horoscope.configList, lua_activity126_horoscope.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity126_horoscope
