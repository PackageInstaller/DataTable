-- chunkname: @modules/configs/excel2json/lua_rouge_synthesis.lua

module("modules.configs.excel2json.lua_rouge_synthesis", package.seeall)

local lua_rouge_synthesis = {}
local fields = {
	id = 1,
	version = 2,
	product = 3,
	synthetics = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_synthesis.onLoad(json)
	lua_rouge_synthesis.configList, lua_rouge_synthesis.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_synthesis
