-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_ddg.lua

module("modules.configs.excel2json.lua_fight_sp_effect_ddg", package.seeall)

local lua_fight_sp_effect_ddg = {}
local fields = {
	addExPointEffect = 2,
	addExPointHang = 3,
	posionHang = 5,
	skinId = 1,
	posionEffect = 4
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_sp_effect_ddg.onLoad(json)
	lua_fight_sp_effect_ddg.configList, lua_fight_sp_effect_ddg.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_ddg
