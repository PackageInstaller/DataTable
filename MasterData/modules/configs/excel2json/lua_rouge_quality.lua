-- chunkname: @modules/configs/excel2json/lua_rouge_quality.lua

module("modules.configs.excel2json.lua_rouge_quality", package.seeall)

local lua_rouge_quality = {}
local fields = {
	id = 1,
	name = 2,
	rareColor = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rouge_quality.onLoad(json)
	lua_rouge_quality.configList, lua_rouge_quality.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_quality
