-- chunkname: @modules/configs/excel2json/lua_rouge_outside_const.lua

module("modules.configs.excel2json.lua_rouge_outside_const", package.seeall)

local lua_rouge_outside_const = {}
local fields = {
	id = 2,
	season = 1,
	value = 3,
	desc = 4
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge_outside_const.onLoad(json)
	lua_rouge_outside_const.configList, lua_rouge_outside_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_outside_const
