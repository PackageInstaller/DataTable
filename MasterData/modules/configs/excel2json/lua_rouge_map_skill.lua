-- chunkname: @modules/configs/excel2json/lua_rouge_map_skill.lua

module("modules.configs.excel2json.lua_rouge_map_skill", package.seeall)

local lua_rouge_map_skill = {}
local fields = {
	icon = 9,
	stepCd = 5,
	middleLayerLimit = 10,
	desc = 8,
	effects = 7,
	coinCost = 4,
	id = 1,
	version = 2,
	powerCost = 3,
	useLimit = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge_map_skill.onLoad(json)
	lua_rouge_map_skill.configList, lua_rouge_map_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_map_skill
