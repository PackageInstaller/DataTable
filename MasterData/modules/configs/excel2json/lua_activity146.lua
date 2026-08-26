-- chunkname: @modules/configs/excel2json/lua_activity146.lua

module("modules.configs.excel2json.lua_activity146", package.seeall)

local lua_activity146 = {}
local fields = {
	openDay = 4,
	name = 5,
	preId = 3,
	interactType = 9,
	text = 6,
	photo = 8,
	id = 2,
	activityId = 1,
	bonus = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	text = 2,
	name = 1
}

function lua_activity146.onLoad(json)
	lua_activity146.configList, lua_activity146.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity146
