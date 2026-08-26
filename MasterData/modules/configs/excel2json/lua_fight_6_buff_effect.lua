-- chunkname: @modules/configs/excel2json/lua_fight_6_buff_effect.lua

module("modules.configs.excel2json.lua_fight_6_buff_effect", package.seeall)

local lua_fight_6_buff_effect = {}
local fields = {
	audioId = 5,
	effectHang = 4,
	buffId = 2,
	effect = 3,
	id = 1
}
local primaryKey = {
	"id",
	"buffId"
}
local mlStringKey = {}

function lua_fight_6_buff_effect.onLoad(json)
	lua_fight_6_buff_effect.configList, lua_fight_6_buff_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_6_buff_effect
