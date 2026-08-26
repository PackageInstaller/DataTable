-- chunkname: @modules/configs/excel2json/lua_rouge_open.lua

module("modules.configs.excel2json.lua_rouge_open", package.seeall)

local lua_rouge_open = {}
local fields = {
	id = 1,
	name = 2,
	version = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rouge_open.onLoad(json)
	lua_rouge_open.configList, lua_rouge_open.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_open
