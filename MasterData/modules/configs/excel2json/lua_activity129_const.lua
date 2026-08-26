-- chunkname: @modules/configs/excel2json/lua_activity129_const.lua

module("modules.configs.excel2json.lua_activity129_const", package.seeall)

local lua_activity129_const = {}
local fields = {
	id = 2,
	value1 = 3,
	activityId = 1,
	value2 = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity129_const.onLoad(json)
	lua_activity129_const.configList, lua_activity129_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity129_const
