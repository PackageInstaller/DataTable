-- chunkname: @modules/configs/excel2json/lua_rouge_layer_rule.lua

module("modules.configs.excel2json.lua_rouge_layer_rule", package.seeall)

local lua_rouge_layer_rule = {}
local fields = {
	version = 1
}
local primaryKey = {}
local mlStringKey = {}

function lua_rouge_layer_rule.onLoad(json)
	lua_rouge_layer_rule.configList, lua_rouge_layer_rule.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_layer_rule
