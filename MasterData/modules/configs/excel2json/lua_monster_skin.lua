-- chunkname: @modules/configs/excel2json/lua_monster_skin.lua

module("modules.configs.excel2json.lua_monster_skin", package.seeall)

local lua_monster_skin = {}
local fields = {
	retangleIcon = 12,
	weatherParam = 14,
	spine = 6,
	name = 2,
	clickBoxUnlimit = 26,
	mainBody = 22,
	nameEng = 3,
	bossSkillSpeed = 24,
	isFly = 9,
	outlineWidth = 25,
	fight_special = 7,
	skills = 10,
	effectHangPoint = 20,
	noDeadEffect = 18,
	des = 4,
	focusOffset = 16,
	effect = 19,
	matId = 13,
	topuiOffset = 15,
	headIcon = 11,
	flipX = 8,
	canHide = 21,
	colorbg = 5,
	showTemplate = 17,
	id = 1,
	floatOffset = 23
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	des = 1
}

function lua_monster_skin.onLoad(json)
	lua_monster_skin.configList, lua_monster_skin.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_monster_skin
