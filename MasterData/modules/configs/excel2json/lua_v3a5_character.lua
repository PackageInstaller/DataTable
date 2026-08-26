-- chunkname: @modules/configs/excel2json/lua_v3a5_character.lua

module("modules.configs.excel2json.lua_v3a5_character", package.seeall)

local lua_v3a5_character = {}
local fields = {
	id = 1,
	name = 3,
	profileId = 2,
	enName = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_v3a5_character.onLoad(json)
	lua_v3a5_character.configList, lua_v3a5_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v3a5_character
