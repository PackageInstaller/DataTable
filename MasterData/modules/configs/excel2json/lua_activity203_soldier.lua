-- chunkname: @modules/configs/excel2json/lua_activity203_soldier.lua

module("modules.configs.excel2json.lua_activity203_soldier", package.seeall)

local lua_activity203_soldier = {}
local fields = {
	description = 4,
	passiveSkill = 8,
	hP = 5,
	type = 2,
	name = 3,
	icon = 9,
	animation = 11,
	resource = 6,
	speed = 7,
	soldierId = 1,
	scale = 10
}
local primaryKey = {
	"soldierId"
}
local mlStringKey = {}

function lua_activity203_soldier.onLoad(json)
	lua_activity203_soldier.configList, lua_activity203_soldier.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity203_soldier
