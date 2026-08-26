-- chunkname: @modules/configs/excel2json/lua_activity209_const.lua

module("modules.configs.excel2json.lua_activity209_const", package.seeall)

local lua_activity209_const = {}
local fields = {
	id = 2,
	value = 3,
	activityId = 1,
	value2 = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity209_const.onLoad(json)
	lua_activity209_const.configList, lua_activity209_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity209_const
