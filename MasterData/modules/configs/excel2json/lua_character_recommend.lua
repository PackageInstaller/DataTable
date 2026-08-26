-- chunkname: @modules/configs/excel2json/lua_character_recommend.lua

module("modules.configs.excel2json.lua_character_recommend", package.seeall)

local lua_character_recommend = {}
local fields = {
	equipRec = 4,
	teamDisplay = 3,
	resonanceRec = 7,
	lvRec = 6,
	id = 1,
	equipDisplay = 5,
	teamRec = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_character_recommend.onLoad(json)
	lua_character_recommend.configList, lua_character_recommend.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_recommend
