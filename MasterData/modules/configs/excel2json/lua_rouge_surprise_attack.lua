-- chunkname: @modules/configs/excel2json/lua_rouge_surprise_attack.lua

module("modules.configs.excel2json.lua_rouge_surprise_attack", package.seeall)

local lua_rouge_surprise_attack = {}
local fields = {
	title = 2,
	hiddenRule = 4,
	ruleDesc = 5,
	tipsDesc = 6,
	id = 1,
	additionRule = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tipsDesc = 3,
	title = 1,
	ruleDesc = 2
}

function lua_rouge_surprise_attack.onLoad(json)
	lua_rouge_surprise_attack.configList, lua_rouge_surprise_attack.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_surprise_attack
