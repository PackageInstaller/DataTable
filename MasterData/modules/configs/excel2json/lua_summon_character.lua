-- chunkname: @modules/configs/excel2json/lua_summon_character.lua

module("modules.configs.excel2json.lua_summon_character", package.seeall)

local lua_summon_character = {}
local fields = {
	id = 1,
	heroId = 2,
	location = 4,
	skinId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_summon_character.onLoad(json)
	lua_summon_character.configList, lua_summon_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summon_character
