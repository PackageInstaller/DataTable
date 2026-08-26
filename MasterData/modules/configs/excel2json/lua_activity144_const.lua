-- chunkname: @modules/configs/excel2json/lua_activity144_const.lua

module("modules.configs.excel2json.lua_activity144_const", package.seeall)

local lua_activity144_const = {}
local fields = {
	activityId = 1,
	value1 = 3,
	id = 2,
	value3 = 5,
	value2 = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	value3 = 1
}

function lua_activity144_const.onLoad(json)
	lua_activity144_const.configList, lua_activity144_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_const
