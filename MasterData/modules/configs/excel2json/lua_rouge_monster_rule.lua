-- chunkname: @modules/configs/excel2json/lua_rouge_monster_rule.lua

module("modules.configs.excel2json.lua_rouge_monster_rule", package.seeall)

local lua_rouge_monster_rule = {}
local fields = {
	id = 1,
	unlockType = 5,
	unlockParam = 6,
	addCollection = 3,
	rare = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge_monster_rule.onLoad(json)
	lua_rouge_monster_rule.configList, lua_rouge_monster_rule.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_monster_rule
