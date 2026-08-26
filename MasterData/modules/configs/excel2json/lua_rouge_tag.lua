-- chunkname: @modules/configs/excel2json/lua_rouge_tag.lua

module("modules.configs.excel2json.lua_rouge_tag", package.seeall)

local lua_rouge_tag = {}
local fields = {
	id = 1,
	name = 2,
	iconUrl = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rouge_tag.onLoad(json)
	lua_rouge_tag.configList, lua_rouge_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_tag
