-- chunkname: @modules/configs/excel2json/lua_activity231_const.lua

module("modules.configs.excel2json.lua_activity231_const", package.seeall)

local lua_activity231_const = {}
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

function lua_activity231_const.onLoad(json)
	lua_activity231_const.configList, lua_activity231_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_const
