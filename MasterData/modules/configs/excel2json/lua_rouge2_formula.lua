-- chunkname: @modules/configs/excel2json/lua_rouge2_formula.lua

module("modules.configs.excel2json.lua_rouge2_formula", package.seeall)

local lua_rouge2_formula = {}
local fields = {
	scoreReward = 9,
	name = 6,
	details = 8,
	isHide = 11,
	mainIdNum = 4,
	condition = 10,
	rare = 3,
	effects = 5,
	id = 1,
	icon = 7,
	sort = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	details = 2,
	name = 1
}

function lua_rouge2_formula.onLoad(json)
	lua_rouge2_formula.configList, lua_rouge2_formula.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_formula
