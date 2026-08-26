-- chunkname: @modules/configs/excel2json/lua_activity164_bubble.lua

module("modules.configs.excel2json.lua_activity164_bubble", package.seeall)

local lua_activity164_bubble = {}
local fields = {
	id = 2,
	content = 4,
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

function lua_activity164_bubble.onLoad(json)
	lua_activity164_bubble.configList, lua_activity164_bubble.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity164_bubble
