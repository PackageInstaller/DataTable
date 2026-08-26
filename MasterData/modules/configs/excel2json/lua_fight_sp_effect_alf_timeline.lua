-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_alf_timeline.lua

module("modules.configs.excel2json.lua_fight_sp_effect_alf_timeline", package.seeall)

local lua_fight_sp_effect_alf_timeline = {}
local fields = {
	timeline_2 = 2,
	timeline_3 = 3,
	timeline_4 = 4,
	skinId = 1
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_sp_effect_alf_timeline.onLoad(json)
	lua_fight_sp_effect_alf_timeline.configList, lua_fight_sp_effect_alf_timeline.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_alf_timeline
