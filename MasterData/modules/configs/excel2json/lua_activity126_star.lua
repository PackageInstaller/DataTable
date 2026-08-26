-- chunkname: @modules/configs/excel2json/lua_activity126_star.lua

module("modules.configs.excel2json.lua_activity126_star", package.seeall)

local lua_activity126_star = {}
local fields = {
	pos = 5,
	tip = 4,
	num = 1,
	activityId = 2,
	bonus = 3
}
local primaryKey = {
	"num",
	"activityId"
}
local mlStringKey = {
	tip = 1
}

function lua_activity126_star.onLoad(json)
	lua_activity126_star.configList, lua_activity126_star.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity126_star
