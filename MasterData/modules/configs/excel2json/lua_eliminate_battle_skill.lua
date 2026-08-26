-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_skill.lua

module("modules.configs.excel2json.lua_eliminate_battle_skill", package.seeall)

local lua_eliminate_battle_skill = {}
local fields = {
	triggerPoint = 7,
	name = 2,
	cd = 6,
	type = 4,
	effect = 9,
	condition = 8,
	desc = 3,
	id = 1,
	icon = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	type = 3,
	name = 1,
	desc = 2
}

function lua_eliminate_battle_skill.onLoad(json)
	lua_eliminate_battle_skill.configList, lua_eliminate_battle_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_battle_skill
