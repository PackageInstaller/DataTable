-- chunkname: @modules/configs/excel2json/lua_activity220_const.lua

module("modules.configs.excel2json.lua_activity220_const", package.seeall)

local lua_activity220_const = {}
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

function lua_activity220_const.onLoad(json)
	lua_activity220_const.configList, lua_activity220_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_const
