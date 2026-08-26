-- chunkname: @modules/configs/excel2json/lua_character_destiny.lua

module("modules.configs.excel2json.lua_character_destiny", package.seeall)

local lua_character_destiny = {}
local fields = {
	facetsId = 3,
	heroId = 1,
	slotsId = 2
}
local primaryKey = {
	"heroId"
}
local mlStringKey = {}

function lua_character_destiny.onLoad(json)
	lua_character_destiny.configList, lua_character_destiny.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_destiny
