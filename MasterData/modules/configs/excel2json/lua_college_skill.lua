-- chunkname: @modules/configs/excel2json/lua_college_skill.lua

module("modules.configs.excel2json.lua_college_skill", package.seeall)

local lua_college_skill = {}
local fields = {
	id = 1,
	name = 2,
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

function lua_college_skill.onLoad(json)
	lua_college_skill.configList, lua_college_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_skill
