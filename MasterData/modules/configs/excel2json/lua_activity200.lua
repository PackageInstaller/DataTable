-- chunkname: @modules/configs/excel2json/lua_activity200.lua

module("modules.configs.excel2json.lua_activity200", package.seeall)

local lua_activity200 = {}
local fields = {
	photo2 = 9,
	name = 4,
	preId = 3,
	photo1 = 8,
	text = 5,
	id = 2,
	position = 7,
	activityId = 1,
	bonus = 6
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	text = 2,
	name = 1
}

function lua_activity200.onLoad(json)
	lua_activity200.configList, lua_activity200.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity200
