-- chunkname: @modules/configs/excel2json/lua_skin_monster_hide_buff_effect.lua

module("modules.configs.excel2json.lua_skin_monster_hide_buff_effect", package.seeall)

local lua_skin_monster_hide_buff_effect = {}
local fields = {
	effectName = 2,
	exceptEffect = 3,
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}

function lua_skin_monster_hide_buff_effect.onLoad(json)
	lua_skin_monster_hide_buff_effect.configList, lua_skin_monster_hide_buff_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skin_monster_hide_buff_effect
