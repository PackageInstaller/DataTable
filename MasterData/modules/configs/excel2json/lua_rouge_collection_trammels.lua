-- chunkname: @modules/configs/excel2json/lua_rouge_collection_trammels.lua

module("modules.configs.excel2json.lua_rouge_collection_trammels", package.seeall)

local lua_rouge_collection_trammels = {}
local fields = {
	id = 1,
	num = 2,
	ruleList = 3,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge_collection_trammels.onLoad(json)
	lua_rouge_collection_trammels.configList, lua_rouge_collection_trammels.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_collection_trammels
