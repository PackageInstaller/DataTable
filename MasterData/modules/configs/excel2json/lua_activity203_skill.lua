-- chunkname: @modules/configs/excel2json/lua_activity203_skill.lua

module("modules.configs.excel2json.lua_activity203_skill", package.seeall)

local lua_activity203_skill = {}
local fields = {
	description = 4,
	name = 3,
	coolDown = 7,
	skillId = 1,
	effect = 6,
	icon = 5,
	target = 2
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}

function lua_activity203_skill.onLoad(json)
	lua_activity203_skill.configList, lua_activity203_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity203_skill
