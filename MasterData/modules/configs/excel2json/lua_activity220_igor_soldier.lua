-- chunkname: @modules/configs/excel2json/lua_activity220_igor_soldier.lua

module("modules.configs.excel2json.lua_activity220_igor_soldier", package.seeall)

local lua_activity220_igor_soldier = {}
local fields = {
	cost = 3,
	isHero = 12,
	damage = 7,
	type = 2,
	counter = 9,
	attackSpeed = 5,
	attackRange = 6,
	unlock = 11,
	speed = 4,
	name = 13,
	desc = 14,
	health = 8,
	id = 1,
	usecd = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity220_igor_soldier.onLoad(json)
	lua_activity220_igor_soldier.configList, lua_activity220_igor_soldier.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_igor_soldier
