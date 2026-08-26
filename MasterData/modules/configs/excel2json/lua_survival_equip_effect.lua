-- chunkname: @modules/configs/excel2json/lua_survival_equip_effect.lua

module("modules.configs.excel2json.lua_survival_equip_effect", package.seeall)

local lua_survival_equip_effect = {}
local fields = {
	id = 1,
	effect = 2,
	effect_score = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_survival_equip_effect.onLoad(json)
	lua_survival_equip_effect.configList, lua_survival_equip_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_equip_effect
