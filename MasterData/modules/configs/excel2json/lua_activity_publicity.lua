-- chunkname: @modules/configs/excel2json/lua_activity_publicity.lua

module("modules.configs.excel2json.lua_activity_publicity", package.seeall)

local lua_activity_publicity = {}
local fields = {
	jumpId = 7,
	slogan = 5,
	activityId = 8,
	type = 2,
	id = 1,
	title = 4,
	showItemId = 6,
	activityBonus = 3
}
local primaryKey = {
	"id",
	"type"
}
local mlStringKey = {}

function lua_activity_publicity.onLoad(json)
	lua_activity_publicity.configList, lua_activity_publicity.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity_publicity
