-- chunkname: @modules/configs/excel2json/lua_rouge_genius.lua

module("modules.configs.excel2json.lua_rouge_genius", package.seeall)

local lua_rouge_genius = {}
local fields = {
	cost = 6,
	name = 3,
	id = 2,
	season = 1,
	icon = 4,
	desc = 5
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rouge_genius.onLoad(json)
	lua_rouge_genius.configList, lua_rouge_genius.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_genius
