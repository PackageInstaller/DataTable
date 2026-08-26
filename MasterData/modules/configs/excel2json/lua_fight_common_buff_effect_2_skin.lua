-- chunkname: @modules/configs/excel2json/lua_fight_common_buff_effect_2_skin.lua

module("modules.configs.excel2json.lua_fight_common_buff_effect_2_skin", package.seeall)

local lua_fight_common_buff_effect_2_skin = {}
local fields = {
	audio = 5,
	effectHang = 3,
	buffId = 1,
	skinId = 2,
	duration = 6,
	effectPath = 4
}
local primaryKey = {
	"buffId",
	"skinId"
}
local mlStringKey = {}

function lua_fight_common_buff_effect_2_skin.onLoad(json)
	lua_fight_common_buff_effect_2_skin.configList, lua_fight_common_buff_effect_2_skin.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_common_buff_effect_2_skin
