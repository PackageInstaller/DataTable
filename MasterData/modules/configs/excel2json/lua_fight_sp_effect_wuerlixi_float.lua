-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_wuerlixi_float.lua

module("modules.configs.excel2json.lua_fight_sp_effect_wuerlixi_float", package.seeall)

local lua_fight_sp_effect_wuerlixi_float = {}
local fields = {
	audioId = 5,
	effect = 2,
	hangPoint = 3,
	skinId = 1,
	duration = 4
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_sp_effect_wuerlixi_float.onLoad(json)
	lua_fight_sp_effect_wuerlixi_float.configList, lua_fight_sp_effect_wuerlixi_float.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_wuerlixi_float
