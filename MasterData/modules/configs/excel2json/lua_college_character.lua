-- chunkname: @modules/configs/excel2json/lua_college_character.lua

module("modules.configs.excel2json.lua_college_character", package.seeall)

local lua_college_character = {}
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

function lua_college_character.onLoad(json)
	lua_college_character.configList, lua_college_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_character
