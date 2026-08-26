-- chunkname: @modules/configs/excel2json/lua_rouge2_ending.lua

module("modules.configs.excel2json.lua_rouge2_ending", package.seeall)

local lua_rouge2_ending = {}
local fields = {
	id = 1,
	endingStoryId = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge2_ending.onLoad(json)
	lua_rouge2_ending.configList, lua_rouge2_ending.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_ending
