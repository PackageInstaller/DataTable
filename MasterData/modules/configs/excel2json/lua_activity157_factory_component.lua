-- chunkname: @modules/configs/excel2json/lua_activity157_factory_component.lua

module("modules.configs.excel2json.lua_activity157_factory_component", package.seeall)

local lua_activity157_factory_component = {}
local fields = {
	componentId = 2,
	preComponentId = 4,
	unlockCondition = 3,
	elementId = 6,
	nextComponentId = 5,
	bonusForShow = 8,
	bonusBuildingLevel = 9,
	activityId = 1,
	bonus = 7
}
local primaryKey = {
	"activityId",
	"componentId"
}
local mlStringKey = {}

function lua_activity157_factory_component.onLoad(json)
	lua_activity157_factory_component.configList, lua_activity157_factory_component.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity157_factory_component
