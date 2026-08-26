-- chunkname: @modules/configs/excel2json/lua_rogue_ending.lua

module("modules.configs.excel2json.lua_rogue_ending", package.seeall)

local lua_rogue_ending = {}
local fields = {
	endingDesc = 6,
	resultIcon = 5,
	storyId = 3,
	id = 1,
	title = 2,
	endingIcon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	endingDesc = 2,
	title = 1
}

function lua_rogue_ending.onLoad(json)
	lua_rogue_ending.configList, lua_rogue_ending.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_ending
