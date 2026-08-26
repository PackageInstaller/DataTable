-- chunkname: @modules/configs/excel2json/lua_activity231_invention.lua

module("modules.configs.excel2json.lua_activity231_invention", package.seeall)

local lua_activity231_invention = {}
local fields = {
	name = 5,
	type = 3,
	id = 2,
	icon = 6,
	activityId = 1,
	recipe = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity231_invention.onLoad(json)
	lua_activity231_invention.configList, lua_activity231_invention.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_invention
