-- chunkname: @modules/configs/excel2json/lua_activity167_bubble.lua

module("modules.configs.excel2json.lua_activity167_bubble", package.seeall)

local lua_activity167_bubble = {}
local fields = {
	interactId = 4,
	content = 6,
	id = 2,
	icon = 5,
	activityId = 1,
	step = 3
}
local primaryKey = {
	"activityId",
	"id",
	"step"
}
local mlStringKey = {
	content = 1
}

function lua_activity167_bubble.onLoad(json)
	lua_activity167_bubble.configList, lua_activity167_bubble.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity167_bubble
