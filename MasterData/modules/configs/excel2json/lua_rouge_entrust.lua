-- chunkname: @modules/configs/excel2json/lua_rouge_entrust.lua

module("modules.configs.excel2json.lua_rouge_entrust", package.seeall)

local lua_rouge_entrust = {}
local fields = {
	interactive = 4,
	param = 3,
	incompleteEffect = 5,
	type = 2,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_entrust.onLoad(json)
	lua_rouge_entrust.configList, lua_rouge_entrust.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_entrust
