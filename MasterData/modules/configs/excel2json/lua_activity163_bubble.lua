-- chunkname: @modules/configs/excel2json/lua_activity163_bubble.lua

module("modules.configs.excel2json.lua_activity163_bubble", package.seeall)

local lua_activity163_bubble = {}
local fields = {
	stepId = 2,
	direction = 5,
	nextStep = 3,
	content = 6,
	id = 1,
	bubbleType = 4
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	content = 1
}

function lua_activity163_bubble.onLoad(json)
	lua_activity163_bubble.configList, lua_activity163_bubble.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity163_bubble
