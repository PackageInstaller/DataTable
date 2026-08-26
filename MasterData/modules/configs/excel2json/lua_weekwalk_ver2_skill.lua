-- chunkname: @modules/configs/excel2json/lua_weekwalk_ver2_skill.lua

module("modules.configs.excel2json.lua_weekwalk_ver2_skill", package.seeall)

local lua_weekwalk_ver2_skill = {}
local fields = {
	rules = 5,
	name = 2,
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

function lua_weekwalk_ver2_skill.onLoad(json)
	lua_weekwalk_ver2_skill.configList, lua_weekwalk_ver2_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_ver2_skill
