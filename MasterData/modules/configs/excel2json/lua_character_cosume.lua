-- chunkname: @modules/configs/excel2json/lua_character_cosume.lua

module("modules.configs.excel2json.lua_character_cosume", package.seeall)

local lua_character_cosume = {}
local fields = {
	cosume = 3,
	rare = 2,
	level = 1
}
local primaryKey = {
	"level",
	"rare"
}
local mlStringKey = {}

function lua_character_cosume.onLoad(json)
	lua_character_cosume.configList, lua_character_cosume.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_cosume
