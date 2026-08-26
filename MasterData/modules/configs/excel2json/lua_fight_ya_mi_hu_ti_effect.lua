-- chunkname: @modules/configs/excel2json/lua_fight_ya_mi_hu_ti_effect.lua

module("modules.configs.excel2json.lua_fight_ya_mi_hu_ti_effect", package.seeall)

local lua_fight_ya_mi_hu_ti_effect = {}
local fields = {
	reverseX = 4,
	effect = 2,
	delEffect = 5,
	audio = 7,
	id = 1,
	delAudio = 8,
	pos = 3,
	delTime = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_ya_mi_hu_ti_effect.onLoad(json)
	lua_fight_ya_mi_hu_ti_effect.configList, lua_fight_ya_mi_hu_ti_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_ya_mi_hu_ti_effect
