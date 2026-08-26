-- chunkname: @modules/configs/excel2json/lua_rouge_talent.lua

module("modules.configs.excel2json.lua_rouge_talent", package.seeall)

local lua_rouge_talent = {}
local fields = {
	cost = 5,
	name = 2,
	id = 1,
	icon = 3,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rouge_talent.onLoad(json)
	lua_rouge_talent.configList, lua_rouge_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_talent
