-- chunkname: @modules/configs/excel2json/lua_arcade_difficulty.lua

module("modules.configs.excel2json.lua_arcade_difficulty", package.seeall)

local lua_arcade_difficulty = {}
local fields = {
	addSkill = 3,
	characterTurnTime = 4,
	scope = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_arcade_difficulty.onLoad(json)
	lua_arcade_difficulty.configList, lua_arcade_difficulty.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_difficulty
