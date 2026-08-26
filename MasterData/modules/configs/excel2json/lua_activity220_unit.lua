-- chunkname: @modules/configs/excel2json/lua_activity220_unit.lua

module("modules.configs.excel2json.lua_activity220_unit", package.seeall)

local lua_activity220_unit = {}
local fields = {
	prefab = 5,
	def = 8,
	hp = 9,
	type = 2,
	monsterSkill = 4,
	atkAnimator = 11,
	keyTime = 10,
	initialAnimator = 12,
	chooseAnimator2 = 14,
	npcId = 1,
	skill = 6,
	atk = 7,
	chooseAnimator1 = 13,
	attribute = 3
}
local primaryKey = {
	"npcId"
}
local mlStringKey = {}

function lua_activity220_unit.onLoad(json)
	lua_activity220_unit.configList, lua_activity220_unit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_unit
