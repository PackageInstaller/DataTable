-- chunkname: @modules/configs/excel2json/lua_rouge_interactive.lua

module("modules.configs.excel2json.lua_rouge_interactive", package.seeall)

local lua_rouge_interactive = {}
local fields = {
	tips = 2,
	id = 1,
	typeParam = 4,
	type = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 1
}

function lua_rouge_interactive.onLoad(json)
	lua_rouge_interactive.configList, lua_rouge_interactive.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_interactive
