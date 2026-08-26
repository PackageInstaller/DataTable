-- chunkname: @modules/configs/excel2json/lua_hero_team.lua

module("modules.configs.excel2json.lua_hero_team", package.seeall)

local lua_hero_team = {}
local fields = {
	isDisplay = 7,
	name = 3,
	unlockId = 4,
	actType = 2,
	minNum = 10,
	maxNum = 11,
	supNum = 6,
	isChangeName = 8,
	id = 1,
	batNum = 5,
	sort = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_hero_team.onLoad(json)
	lua_hero_team.configList, lua_hero_team.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_team
