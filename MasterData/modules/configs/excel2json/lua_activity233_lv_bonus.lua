-- chunkname: @modules/configs/excel2json/lua_activity233_lv_bonus.lua

module("modules.configs.excel2json.lua_activity233_lv_bonus", package.seeall)

local lua_activity233_lv_bonus = {}
local fields = {
	keyBonus = 5,
	bpId = 1,
	payBonus = 4,
	freeBonus = 3,
	level = 2
}
local primaryKey = {
	"bpId",
	"level"
}
local mlStringKey = {}

function lua_activity233_lv_bonus.onLoad(json)
	lua_activity233_lv_bonus.configList, lua_activity233_lv_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity233_lv_bonus
