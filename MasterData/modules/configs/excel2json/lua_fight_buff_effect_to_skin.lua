-- chunkname: @modules/configs/excel2json/lua_fight_buff_effect_to_skin.lua

module("modules.configs.excel2json.lua_fight_buff_effect_to_skin", package.seeall)

local lua_fight_buff_effect_to_skin = {}
local fields = {
	buffId = 1,
	skinIdList = 2
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}

function lua_fight_buff_effect_to_skin.onLoad(json)
	lua_fight_buff_effect_to_skin.configList, lua_fight_buff_effect_to_skin.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_buff_effect_to_skin
