-- chunkname: @modules/configs/excel2json/lua_survival_role_skill.lua

module("modules.configs.excel2json.lua_survival_role_skill", package.seeall)

local lua_survival_role_skill = {}
local fields = {
	effect1 = 6,
	resource = 3,
	times = 4,
	effect2 = 7,
	id = 1,
	effect3 = 8,
	addTalentIds = 5,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_survival_role_skill.onLoad(json)
	lua_survival_role_skill.configList, lua_survival_role_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_role_skill
