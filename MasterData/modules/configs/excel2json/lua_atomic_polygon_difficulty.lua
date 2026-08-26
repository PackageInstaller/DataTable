-- chunkname: @modules/configs/excel2json/lua_atomic_polygon_difficulty.lua

module("modules.configs.excel2json.lua_atomic_polygon_difficulty", package.seeall)

local lua_atomic_polygon_difficulty = {}
local fields = {
	description = 7,
	name = 6,
	image = 5,
	unlockCondition = 4,
	episodeId = 8,
	skillId = 9,
	id = 1,
	difficulty = 2,
	conditionType = 3
}
local primaryKey = {
	"id",
	"difficulty"
}
local mlStringKey = {
	description = 2,
	name = 1
}

function lua_atomic_polygon_difficulty.onLoad(json)
	lua_atomic_polygon_difficulty.configList, lua_atomic_polygon_difficulty.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_polygon_difficulty
