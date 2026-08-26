-- chunkname: @modules/configs/excel2json/lua_activity168_const.lua

module("modules.configs.excel2json.lua_activity168_const", package.seeall)

local lua_activity168_const = {}
local fields = {
	activityId = 1,
	value1 = 3,
	mlValue = 5,
	id = 2,
	value2 = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	value2 = 1,
	mlValue = 2
}

function lua_activity168_const.onLoad(json)
	lua_activity168_const.configList, lua_activity168_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity168_const
