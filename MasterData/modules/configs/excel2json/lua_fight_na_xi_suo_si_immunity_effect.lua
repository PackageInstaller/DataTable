-- chunkname: @modules/configs/excel2json/lua_fight_na_xi_suo_si_immunity_effect.lua

module("modules.configs.excel2json.lua_fight_na_xi_suo_si_immunity_effect", package.seeall)

local lua_fight_na_xi_suo_si_immunity_effect = {}
local fields = {
	effect = 2,
	effectHang = 3,
	audio = 4,
	id = 1,
	duration = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_na_xi_suo_si_immunity_effect.onLoad(json)
	lua_fight_na_xi_suo_si_immunity_effect.configList, lua_fight_na_xi_suo_si_immunity_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_na_xi_suo_si_immunity_effect
