-- chunkname: @modules/configs/excel2json/lua_character_rank.lua

module("modules.configs.excel2json.lua_character_rank", package.seeall)

local lua_character_rank = {}
local fields = {
	requirement = 4,
	heroId = 1,
	rank = 2,
	consume = 3,
	effect = 5
}
local primaryKey = {
	"heroId",
	"rank"
}
local mlStringKey = {}

function lua_character_rank.onLoad(json)
	lua_character_rank.configList, lua_character_rank.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_rank
