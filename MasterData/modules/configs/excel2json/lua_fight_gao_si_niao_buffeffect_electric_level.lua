-- chunkname: @modules/configs/excel2json/lua_fight_gao_si_niao_buffeffect_electric_level.lua

module("modules.configs.excel2json.lua_fight_gao_si_niao_buffeffect_electric_level", package.seeall)

local lua_fight_gao_si_niao_buffeffect_electric_level = {}
local fields = {
	electricLevel = 3,
	effect = 4,
	effectHangPoint = 5,
	audio = 6,
	id = 1,
	skin = 2
}
local primaryKey = {
	"id",
	"skin",
	"electricLevel"
}
local mlStringKey = {}

function lua_fight_gao_si_niao_buffeffect_electric_level.onLoad(json)
	lua_fight_gao_si_niao_buffeffect_electric_level.configList, lua_fight_gao_si_niao_buffeffect_electric_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_gao_si_niao_buffeffect_electric_level
