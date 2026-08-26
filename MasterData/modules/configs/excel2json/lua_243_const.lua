-- chunkname: @modules/configs/excel2json/lua_243_const.lua

module("modules.configs.excel2json.lua_243_const", package.seeall)

local lua_243_const = {}
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
local mlStringKey = {
	value2 = 1
}

function lua_243_const.onLoad(json)
	lua_243_const.configList, lua_243_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_243_const
