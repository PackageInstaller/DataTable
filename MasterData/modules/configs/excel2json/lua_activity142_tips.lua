-- chunkname: @modules/configs/excel2json/lua_activity142_tips.lua

module("modules.configs.excel2json.lua_activity142_tips", package.seeall)

local lua_activity142_tips = {}
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
local mlStringKey = {}

function lua_activity142_tips.onLoad(json)
	lua_activity142_tips.configList, lua_activity142_tips.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity142_tips
