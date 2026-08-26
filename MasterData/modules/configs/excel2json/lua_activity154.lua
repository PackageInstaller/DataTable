-- chunkname: @modules/configs/excel2json/lua_activity154.lua

module("modules.configs.excel2json.lua_activity154", package.seeall)

local lua_activity154 = {}
local fields = {
	puzzleTitle = 4,
	puzzleDesc = 5,
	puzzleId = 3,
	puzzleIcon = 6,
	answerId = 7,
	bonus = 8,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {
	puzzleTitle = 1,
	puzzleDesc = 2
}

function lua_activity154.onLoad(json)
	lua_activity154.configList, lua_activity154.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity154
