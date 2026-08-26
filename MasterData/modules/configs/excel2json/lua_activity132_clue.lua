-- chunkname: @modules/configs/excel2json/lua_activity132_clue.lua

module("modules.configs.excel2json.lua_activity132_clue", package.seeall)

local lua_activity132_clue = {}
local fields = {
	contents = 4,
	name = 3,
	pos = 5,
	clueId = 2,
	smallBg = 6,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"clueId"
}
local mlStringKey = {
	name = 1
}

function lua_activity132_clue.onLoad(json)
	lua_activity132_clue.configList, lua_activity132_clue.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity132_clue
