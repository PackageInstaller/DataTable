-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_wuerlixi_timeline.lua

module("modules.configs.excel2json.lua_fight_sp_effect_wuerlixi_timeline", package.seeall)

local lua_fight_sp_effect_wuerlixi_timeline = {}
local fields = {
	mySideTimeline = 2,
	enemySideTimeline = 3,
	skinId = 1
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_sp_effect_wuerlixi_timeline.onLoad(json)
	lua_fight_sp_effect_wuerlixi_timeline.configList, lua_fight_sp_effect_wuerlixi_timeline.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_wuerlixi_timeline
