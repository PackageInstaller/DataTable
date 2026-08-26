-- chunkname: @modules/configs/excel2json/lua_activity231_material.lua

module("modules.configs.excel2json.lua_activity231_material", package.seeall)

local lua_activity231_material = {}
local fields = {
	cost = 7,
	name = 5,
	advantage = 8,
	type = 3,
	id = 2,
	unlockCondition = 4,
	activityId = 1,
	icon = 6
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity231_material.onLoad(json)
	lua_activity231_material.configList, lua_activity231_material.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_material
