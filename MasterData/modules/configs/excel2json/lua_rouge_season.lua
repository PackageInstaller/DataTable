-- chunkname: @modules/configs/excel2json/lua_rouge_season.lua

module("modules.configs.excel2json.lua_rouge_season", package.seeall)

local lua_rouge_season = {}
local fields = {
	season = 2,
	name = 4,
	desc = 6,
	id = 1,
	version = 3,
	enName = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 3,
	name = 1,
	enName = 2
}

function lua_rouge_season.onLoad(json)
	lua_rouge_season.configList, lua_rouge_season.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_season
