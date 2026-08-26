-- chunkname: @modules/configs/excel2json/lua_activity121_clue.lua

module("modules.configs.excel2json.lua_activity121_clue", package.seeall)

local lua_activity121_clue = {}
local fields = {
	storyTag = 5,
	name = 3,
	clueId = 1,
	tagType = 4,
	activityId = 2
}
local primaryKey = {
	"clueId",
	"activityId"
}
local mlStringKey = {
	name = 1
}

function lua_activity121_clue.onLoad(json)
	lua_activity121_clue.configList, lua_activity121_clue.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity121_clue
