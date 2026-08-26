-- chunkname: @modules/configs/excel2json/lua_skill_specialbuff.lua

module("modules.configs.excel2json.lua_skill_specialbuff", package.seeall)

local lua_skill_specialbuff = {}
local fields = {
	id = 1,
	icon = 2,
	lv = 3,
	isSpecial = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_skill_specialbuff.onLoad(json)
	lua_skill_specialbuff.configList, lua_skill_specialbuff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_specialbuff
