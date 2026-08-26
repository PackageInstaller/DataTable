-- chunkname: @modules/configs/excel2json/lua_fight_effect_buff_skin.lua

module("modules.configs.excel2json.lua_fight_effect_buff_skin", package.seeall)

local lua_fight_effect_buff_skin = {}
local fields = {
	triggerAudio = 8,
	effectHang = 4,
	buffId = 1,
	skinId = 3,
	orEnemy = 2,
	delAudio = 9,
	effectPath = 5,
	audio = 10,
	triggerEffect = 6,
	delEffect = 7
}
local primaryKey = {
	"buffId",
	"orEnemy",
	"skinId"
}
local mlStringKey = {}

function lua_fight_effect_buff_skin.onLoad(json)
	lua_fight_effect_buff_skin.configList, lua_fight_effect_buff_skin.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_effect_buff_skin
