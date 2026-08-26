-- chunkname: @modules/configs/excel2json/lua_activity231_skill.lua

module("modules.configs.excel2json.lua_activity231_skill", package.seeall)

local lua_activity231_skill = {}
local fields = {
	effectIds = 7,
	name = 2,
	cd = 6,
	type = 5,
	id = 1,
	icon = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity231_skill.onLoad(json)
	lua_activity231_skill.configList, lua_activity231_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_skill
