-- chunkname: @modules/configs/excel2json/lua_activity130_element.lua

module("modules.configs.excel2json.lua_activity130_element", package.seeall)

local lua_activity130_element = {}
local fields = {
	param = 4,
	res = 6,
	elementId = 2,
	type = 3,
	activityId = 1,
	skipFinish = 5
}
local primaryKey = {
	"activityId",
	"elementId"
}
local mlStringKey = {}

function lua_activity130_element.onLoad(json)
	lua_activity130_element.configList, lua_activity130_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity130_element
