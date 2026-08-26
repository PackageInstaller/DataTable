-- chunkname: @modules/configs/excel2json/lua_rouge_enchant.lua

module("modules.configs.excel2json.lua_rouge_enchant", package.seeall)

local lua_rouge_enchant = {}
local fields = {
	id = 1,
	name = 2,
	enchantState = 4,
	baseId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_enchant.onLoad(json)
	lua_rouge_enchant.configList, lua_rouge_enchant.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_enchant
