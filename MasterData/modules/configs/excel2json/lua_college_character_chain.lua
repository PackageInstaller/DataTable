-- chunkname: @modules/configs/excel2json/lua_college_character_chain.lua

module("modules.configs.excel2json.lua_college_character_chain", package.seeall)

local lua_college_character_chain = {}
local fields = {
	id = 1,
	stateId = 3,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_college_character_chain.onLoad(json)
	lua_college_character_chain.configList, lua_college_character_chain.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_character_chain
