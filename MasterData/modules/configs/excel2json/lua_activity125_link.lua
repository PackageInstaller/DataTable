-- chunkname: @modules/configs/excel2json/lua_activity125_link.lua

module("modules.configs.excel2json.lua_activity125_link", package.seeall)

local lua_activity125_link = {}
local fields = {
	id = 1,
	link = 3,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity125_link.onLoad(json)
	lua_activity125_link.configList, lua_activity125_link.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity125_link
