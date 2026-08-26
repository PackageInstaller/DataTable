-- chunkname: @modules/configs/excel2json/lua_copost_character_chain.lua

module("modules.configs.excel2json.lua_copost_character_chain", package.seeall)

local lua_copost_character_chain = {}
local fields = {
	id = 1,
	fightId = 2,
	stateId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_copost_character_chain.onLoad(json)
	lua_copost_character_chain.configList, lua_copost_character_chain.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_character_chain
