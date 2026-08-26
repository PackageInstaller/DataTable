-- chunkname: @modules/configs/excel2json/lua_bp_lv_bonus.lua

module("modules.configs.excel2json.lua_bp_lv_bonus", package.seeall)

local lua_bp_lv_bonus = {}
local fields = {
	selfSelectPayItem = 9,
	spFreeBonus = 6,
	selfSelectPayBonus = 8,
	payBonus = 4,
	keyBonus = 5,
	bpId = 1,
	spPayBonus = 7,
	freeBonus = 3,
	level = 2
}
local primaryKey = {
	"bpId",
	"level"
}
local mlStringKey = {}

function lua_bp_lv_bonus.onLoad(json)
	lua_bp_lv_bonus.configList, lua_bp_lv_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bp_lv_bonus
