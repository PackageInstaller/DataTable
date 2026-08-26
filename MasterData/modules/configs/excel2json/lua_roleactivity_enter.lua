-- chunkname: @modules/configs/excel2json/lua_roleactivity_enter.lua

module("modules.configs.excel2json.lua_roleactivity_enter", package.seeall)

local lua_roleactivity_enter = {}
local fields = {
	storyGroupId = 2,
	activityId = 1,
	episodeGroupId = 3
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_roleactivity_enter.onLoad(json)
	lua_roleactivity_enter.configList, lua_roleactivity_enter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_roleactivity_enter
