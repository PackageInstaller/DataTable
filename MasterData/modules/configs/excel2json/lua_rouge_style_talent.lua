-- chunkname: @modules/configs/excel2json/lua_rouge_style_talent.lua

module("modules.configs.excel2json.lua_rouge_style_talent", package.seeall)

local lua_rouge_style_talent = {}
local fields = {
	interactive = 4,
	unlockType = 8,
	desc = 7,
	type = 2,
	id = 1,
	version = 3,
	ban = 6,
	attribute = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge_style_talent.onLoad(json)
	lua_rouge_style_talent.configList, lua_rouge_style_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_style_talent
