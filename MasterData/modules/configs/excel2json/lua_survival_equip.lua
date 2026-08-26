-- chunkname: @modules/configs/excel2json/lua_survival_equip.lua

module("modules.configs.excel2json.lua_survival_equip", package.seeall)

local lua_survival_equip = {}
local fields = {
	score = 4,
	extendCost = 2,
	id = 1,
	effectDesc = 5,
	group = 3,
	desc = 7,
	effect = 9,
	effectDesc2 = 6,
	tag = 8,
	equipType = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	effectDesc = 1,
	desc = 3,
	effectDesc2 = 2
}

function lua_survival_equip.onLoad(json)
	lua_survival_equip.configList, lua_survival_equip.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_equip
