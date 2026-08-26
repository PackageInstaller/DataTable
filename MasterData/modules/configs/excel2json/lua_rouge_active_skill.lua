-- chunkname: @modules/configs/excel2json/lua_rouge_active_skill.lua

module("modules.configs.excel2json.lua_rouge_active_skill", package.seeall)

local lua_rouge_active_skill = {}
local fields = {
	roundLimit = 5,
	icon = 8,
	coinCost = 4,
	allLimit = 6,
	id = 1,
	version = 2,
	powerCost = 3,
	desc = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge_active_skill.onLoad(json)
	lua_rouge_active_skill.configList, lua_rouge_active_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_active_skill
