-- chunkname: @modules/configs/excel2json/lua_racing_const.lua

module("modules.configs.excel2json.lua_racing_const", package.seeall)

local lua_racing_const = {}
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

function lua_racing_const.onLoad(json)
	lua_racing_const.configList, lua_racing_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_racing_const
