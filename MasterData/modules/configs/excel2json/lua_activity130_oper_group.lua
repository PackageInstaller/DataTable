-- chunkname: @modules/configs/excel2json/lua_activity130_oper_group.lua

module("modules.configs.excel2json.lua_activity130_oper_group", package.seeall)

local lua_activity130_oper_group = {}
local fields = {
	operGroupId = 2,
	descImg = 5,
	name = 9,
	operDesc = 4,
	operType = 3,
	audioId = 8,
	shapegetImg = 7,
	shapeImg = 6,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"operGroupId",
	"operType"
}
local mlStringKey = {
	name = 2,
	operDesc = 1
}

function lua_activity130_oper_group.onLoad(json)
	lua_activity130_oper_group.configList, lua_activity130_oper_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity130_oper_group
