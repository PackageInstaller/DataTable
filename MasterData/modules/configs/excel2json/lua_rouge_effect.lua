-- chunkname: @modules/configs/excel2json/lua_rouge_effect.lua

module("modules.configs.excel2json.lua_rouge_effect", package.seeall)

local lua_rouge_effect = {}
local fields = {
	tips = 2,
	typeParam = 5,
	type = 4,
	id = 1,
	version = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 1
}

function lua_rouge_effect.onLoad(json)
	lua_rouge_effect.configList, lua_rouge_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_effect
