-- chunkname: @modules/configs/excel2json/lua_copost_character.lua

module("modules.configs.excel2json.lua_copost_character", package.seeall)

local lua_copost_character = {}
local fields = {
	chaName = 3,
	chaPicture = 2,
	chaCamp = 4,
	chaId = 1
}
local primaryKey = {
	"chaId"
}
local mlStringKey = {
	chaName = 1
}

function lua_copost_character.onLoad(json)
	lua_copost_character.configList, lua_copost_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_character
