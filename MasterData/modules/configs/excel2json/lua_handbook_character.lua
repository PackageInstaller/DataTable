-- chunkname: @modules/configs/excel2json/lua_handbook_character.lua

module("modules.configs.excel2json.lua_handbook_character", package.seeall)

local lua_handbook_character = {}
local fields = {
	id = 1,
	name = 2,
	nameEng = 3,
	icon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_handbook_character.onLoad(json)
	lua_handbook_character.configList, lua_handbook_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_handbook_character
