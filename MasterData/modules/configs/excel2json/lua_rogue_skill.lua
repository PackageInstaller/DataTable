-- chunkname: @modules/configs/excel2json/lua_rogue_skill.lua

module("modules.configs.excel2json.lua_rogue_skill", package.seeall)

local lua_rogue_skill = {}
local fields = {
	num = 2,
	desc = 6,
	skills = 5,
	id = 1,
	icon = 3,
	attr = 4
}
local primaryKey = {
	"id",
	"num"
}
local mlStringKey = {
	desc = 1
}

function lua_rogue_skill.onLoad(json)
	lua_rogue_skill.configList, lua_rogue_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_skill
