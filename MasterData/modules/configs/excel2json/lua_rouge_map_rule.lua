-- chunkname: @modules/configs/excel2json/lua_rouge_map_rule.lua

module("modules.configs.excel2json.lua_rouge_map_rule", package.seeall)

local lua_rouge_map_rule = {}
local fields = {
	group = 3,
	id = 1,
	type = 2,
	addCollection = 4,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge_map_rule.onLoad(json)
	lua_rouge_map_rule.configList, lua_rouge_map_rule.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_map_rule
