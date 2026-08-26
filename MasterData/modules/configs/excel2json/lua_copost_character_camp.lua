-- chunkname: @modules/configs/excel2json/lua_copost_character_camp.lua

module("modules.configs.excel2json.lua_copost_character_camp", package.seeall)

local lua_copost_character_camp = {}
local fields = {
	text = 5,
	camp = 2,
	unlockId = 6,
	location = 3,
	id = 1,
	textId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	text = 2,
	camp = 1
}

function lua_copost_character_camp.onLoad(json)
	lua_copost_character_camp.configList, lua_copost_character_camp.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_character_camp
