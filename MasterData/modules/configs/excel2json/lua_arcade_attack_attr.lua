-- chunkname: @modules/configs/excel2json/lua_arcade_attack_attr.lua

module("modules.configs.excel2json.lua_arcade_attack_attr", package.seeall)

local lua_arcade_attack_attr = {}
local fields = {
	id = 1,
	name = 2,
	hitActionShow = 3,
	skills = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_attack_attr.onLoad(json)
	lua_arcade_attack_attr.configList, lua_arcade_attack_attr.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_attack_attr
