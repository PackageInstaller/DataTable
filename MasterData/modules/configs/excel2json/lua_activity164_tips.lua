-- chunkname: @modules/configs/excel2json/lua_activity164_tips.lua

module("modules.configs.excel2json.lua_activity164_tips", package.seeall)

local lua_activity164_tips = {}
local fields = {
	id = 2,
	content = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	content = 1
}

function lua_activity164_tips.onLoad(json)
	lua_activity164_tips.configList, lua_activity164_tips.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity164_tips
