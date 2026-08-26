-- chunkname: @modules/configs/excel2json/lua_auto_chess.lua

module("modules.configs.excel2json.lua_auto_chess", package.seeall)

local lua_auto_chess = {}
local fields = {
	attackMode = 14,
	name = 6,
	tag = 9,
	type = 4,
	skillDesc = 13,
	cds = 17,
	specialShopCost = 18,
	image = 21,
	race = 7,
	moveType = 15,
	attack = 10,
	star = 2,
	skillIds = 12,
	illustrationShow = 3,
	durability = 16,
	fixExp = 19,
	subRace = 8,
	hp = 11,
	id = 1,
	levelFromMall = 5,
	initBuff = 20
}
local primaryKey = {
	"id",
	"star"
}
local mlStringKey = {
	skillDesc = 2,
	name = 1
}

function lua_auto_chess.onLoad(json)
	lua_auto_chess.configList, lua_auto_chess.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess
