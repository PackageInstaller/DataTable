-- chunkname: @modules/configs/excel2json/lua_activity120_tips.lua

module("modules.configs.excel2json.lua_activity120_tips", package.seeall)

local lua_activity120_tips = {}
local fields = {
	id = 2,
	tips = 3,
	activityId = 1,
	audioId = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	tips = 1
}

function lua_activity120_tips.onLoad(json)
	lua_activity120_tips.configList, lua_activity120_tips.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity120_tips
