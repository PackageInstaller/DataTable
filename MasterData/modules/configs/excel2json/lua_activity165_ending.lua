-- chunkname: @modules/configs/excel2json/lua_activity165_ending.lua

module("modules.configs.excel2json.lua_activity165_ending", package.seeall)

local lua_activity165_ending = {}
local fields = {
	text = 5,
	level = 6,
	pic = 7,
	endingText = 4,
	endingId = 1,
	finalStepId = 3,
	belongStoryId = 2
}
local primaryKey = {
	"endingId"
}
local mlStringKey = {
	text = 2,
	endingText = 1
}

function lua_activity165_ending.onLoad(json)
	lua_activity165_ending.configList, lua_activity165_ending.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity165_ending
