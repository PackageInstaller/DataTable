-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_wuerlixi.lua

module("modules.configs.excel2json.lua_fight_sp_effect_wuerlixi", package.seeall)

local lua_fight_sp_effect_wuerlixi = {}
local fields = {
	hangPoint = 4,
	effect = 3,
	channelHangPoint = 5,
	skinId = 2,
	buffTypeId = 1
}
local primaryKey = {
	"buffTypeId",
	"skinId"
}
local mlStringKey = {}

function lua_fight_sp_effect_wuerlixi.onLoad(json)
	lua_fight_sp_effect_wuerlixi.configList, lua_fight_sp_effect_wuerlixi.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_wuerlixi
