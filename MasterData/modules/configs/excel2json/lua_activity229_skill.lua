-- chunkname: @modules/configs/excel2json/lua_activity229_skill.lua

module("modules.configs.excel2json.lua_activity229_skill", package.seeall)

local lua_activity229_skill = {}
local fields = {
	rulesTarget = 5,
	name = 2,
	rules = 6,
	id = 1,
	icon = 3,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity229_skill.onLoad(json)
	lua_activity229_skill.configList, lua_activity229_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity229_skill
