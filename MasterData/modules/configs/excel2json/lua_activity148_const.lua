-- chunkname: @modules/configs/excel2json/lua_activity148_const.lua

module("modules.configs.excel2json.lua_activity148_const", package.seeall)

local lua_activity148_const = {}
local fields = {
	id = 1,
	value = 3,
	activityId = 2
}
local primaryKey = {
	"id",
	"activityId"
}
local mlStringKey = {}

function lua_activity148_const.onLoad(json)
	lua_activity148_const.configList, lua_activity148_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity148_const
