-- chunkname: @modules/configs/excel2json/lua_activity122_character.lua

module("modules.configs.excel2json.lua_activity122_character", package.seeall)

local lua_activity122_character = {}
local fields = {
	activityId = 1,
	pushOverObstacle = 7,
	fireDecrHp = 6,
	trapDecrHp = 5,
	destroyObstacle = 4,
	moveObstacle = 3,
	characterType = 2
}
local primaryKey = {
	"activityId",
	"characterType"
}
local mlStringKey = {}

function lua_activity122_character.onLoad(json)
	lua_activity122_character.configList, lua_activity122_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity122_character
