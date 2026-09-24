-- chunkname: @modules/configs/excel2json/lua_activity220_sp_hongnujian_game.lua

module("modules.configs.excel2json.lua_activity220_sp_hongnujian_game", package.seeall)

local lua_activity220_sp_hongnujian_game = {}
local fields = {
	winDesc = 9,
	isGravity = 11,
	time = 3,
	res = 12,
	winType = 7,
	lifeShow = 6,
	monsterTeam = 4,
	isEnergy = 10,
	life = 5,
	id = 2,
	winParam = 8,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	winDesc = 1
}

function lua_activity220_sp_hongnujian_game.onLoad(json)
	lua_activity220_sp_hongnujian_game.configList, lua_activity220_sp_hongnujian_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_sp_hongnujian_game
