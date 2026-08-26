-- chunkname: @modules/configs/excel2json/lua_activity176_bubble.lua

module("modules.configs.excel2json.lua_activity176_bubble", package.seeall)

local lua_activity176_bubble = {}
local fields = {
	content = 5,
	id = 2,
	icon = 4,
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

function lua_activity176_bubble.onLoad(json)
	lua_activity176_bubble.configList, lua_activity176_bubble.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity176_bubble
