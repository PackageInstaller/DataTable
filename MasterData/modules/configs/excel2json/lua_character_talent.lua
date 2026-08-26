-- chunkname: @modules/configs/excel2json/lua_character_talent.lua

module("modules.configs.excel2json.lua_character_talent", package.seeall)

local lua_character_talent = {}
local fields = {
	requirement = 5,
	heroId = 1,
	consume = 6,
	exclusive = 4,
	talentMould = 3,
	talentId = 2
}
local primaryKey = {
	"heroId",
	"talentId"
}
local mlStringKey = {}

function lua_character_talent.onLoad(json)
	lua_character_talent.configList, lua_character_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_talent
