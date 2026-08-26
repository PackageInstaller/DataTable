-- chunkname: @modules/configs/excel2json/lua_assassin_monster.lua

module("modules.configs.excel2json.lua_assassin_monster", package.seeall)

local lua_assassin_monster = {}
local fields = {
	param = 3,
	boss = 5,
	scanRate = 4,
	type = 2,
	position = 9,
	icon = 10,
	rule = 7,
	posOrder = 11,
	model = 6,
	id = 1,
	notMove = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_assassin_monster.onLoad(json)
	lua_assassin_monster.configList, lua_assassin_monster.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_monster
