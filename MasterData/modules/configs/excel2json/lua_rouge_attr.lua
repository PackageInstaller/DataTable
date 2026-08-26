-- chunkname: @modules/configs/excel2json/lua_rouge_attr.lua

module("modules.configs.excel2json.lua_rouge_attr", package.seeall)

local lua_rouge_attr = {}
local fields = {
	id = 1,
	flag = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_attr.onLoad(json)
	lua_rouge_attr.configList, lua_rouge_attr.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_attr
