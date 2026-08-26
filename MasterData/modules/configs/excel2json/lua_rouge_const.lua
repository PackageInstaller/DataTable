-- chunkname: @modules/configs/excel2json/lua_rouge_const.lua

module("modules.configs.excel2json.lua_rouge_const", package.seeall)

local lua_rouge_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value2 = 1
}

function lua_rouge_const.onLoad(json)
	lua_rouge_const.configList, lua_rouge_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_const
