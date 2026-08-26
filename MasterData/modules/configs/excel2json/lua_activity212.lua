-- chunkname: @modules/configs/excel2json/lua_activity212.lua

module("modules.configs.excel2json.lua_activity212", package.seeall)

local lua_activity212 = {}
local fields = {
	id = 1,
	link = 3,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity212.onLoad(json)
	lua_activity212.configList, lua_activity212.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity212
