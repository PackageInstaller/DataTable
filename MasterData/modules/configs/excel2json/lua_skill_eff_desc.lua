-- chunkname: @modules/configs/excel2json/lua_skill_eff_desc.lua

module("modules.configs.excel2json.lua_skill_eff_desc", package.seeall)

local lua_skill_eff_desc = {}
local fields = {
	id = 1,
	name = 2,
	notAddLink = 4,
	isSpecialCharacter = 5,
	color = 3,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_skill_eff_desc.onLoad(json)
	lua_skill_eff_desc.configList, lua_skill_eff_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_eff_desc
