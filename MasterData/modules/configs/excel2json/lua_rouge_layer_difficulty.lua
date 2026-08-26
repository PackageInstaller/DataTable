-- chunkname: @modules/configs/excel2json/lua_rouge_layer_difficulty.lua

module("modules.configs.excel2json.lua_rouge_layer_difficulty", package.seeall)

local lua_rouge_layer_difficulty = {}
local fields = {
	stepAttr = 3,
	difficulty = 1,
	layer = 2
}
local primaryKey = {
	"difficulty",
	"layer"
}
local mlStringKey = {}

function lua_rouge_layer_difficulty.onLoad(json)
	lua_rouge_layer_difficulty.configList, lua_rouge_layer_difficulty.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_layer_difficulty
