-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_buff.lua

module("modules.configs.excel2json.lua_eliminate_battle_buff", package.seeall)

local lua_eliminate_battle_buff = {}
local fields = {
	triggerPoint = 2,
	effect = 3,
	name = 6,
	icon = 8,
	id = 1,
	cover = 4,
	limit = 5,
	desc = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_eliminate_battle_buff.onLoad(json)
	lua_eliminate_battle_buff.configList, lua_eliminate_battle_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_battle_buff
