-- chunkname: @modules/configs/excel2json/lua_activity236_control.lua

module("modules.configs.excel2json.lua_activity236_control", package.seeall)

local lua_activity236_control = {}
local fields = {
	id = 1,
	conversionRate = 3,
	costId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity236_control.onLoad(json)
	lua_activity236_control.configList, lua_activity236_control.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity236_control
