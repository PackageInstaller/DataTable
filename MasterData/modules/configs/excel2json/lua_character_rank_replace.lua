-- chunkname: @modules/configs/excel2json/lua_character_rank_replace.lua

module("modules.configs.excel2json.lua_character_rank_replace", package.seeall)

local lua_character_rank_replace = {}
local fields = {
	skill = 3,
	heroType = 5,
	id = 1,
	uniqueSkill_point = 2,
	exSkill = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_character_rank_replace.onLoad(json)
	lua_character_rank_replace.configList, lua_character_rank_replace.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_rank_replace
