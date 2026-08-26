-- chunkname: @modules/configs/excel2json/lua_rouge_level.lua

module("modules.configs.excel2json.lua_rouge_level", package.seeall)

local lua_rouge_level = {}
local fields = {
	season = 1,
	exp = 3,
	level = 2
}
local primaryKey = {
	"season",
	"level"
}
local mlStringKey = {}

function lua_rouge_level.onLoad(json)
	lua_rouge_level.configList, lua_rouge_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_level
