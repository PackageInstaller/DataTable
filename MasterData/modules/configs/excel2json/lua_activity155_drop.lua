-- chunkname: @modules/configs/excel2json/lua_activity155_drop.lua

module("modules.configs.excel2json.lua_activity155_drop", package.seeall)

local lua_activity155_drop = {}
local fields = {
	itemId1 = 4,
	itemId2 = 5,
	chapterId = 3,
	id = 1,
	activityId = 2
}
local primaryKey = {
	"id",
	"activityId"
}
local mlStringKey = {}

function lua_activity155_drop.onLoad(json)
	lua_activity155_drop.configList, lua_activity155_drop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity155_drop
