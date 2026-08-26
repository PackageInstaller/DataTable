-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_alf_record_buff_effect.lua

module("modules.configs.excel2json.lua_fight_sp_effect_alf_record_buff_effect", package.seeall)

local lua_fight_sp_effect_alf_record_buff_effect = {}
local fields = {
	effect3 = 3,
	effect4 = 4,
	effect2 = 2,
	skinId = 1
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_sp_effect_alf_record_buff_effect.onLoad(json)
	lua_fight_sp_effect_alf_record_buff_effect.configList, lua_fight_sp_effect_alf_record_buff_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_alf_record_buff_effect
