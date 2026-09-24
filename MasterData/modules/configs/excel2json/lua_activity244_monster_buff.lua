-- chunkname: @modules/configs/excel2json/lua_activity244_monster_buff.lua

module("modules.configs.excel2json.lua_activity244_monster_buff", package.seeall)

local lua_activity244_monster_buff = {}
local fields = {
	durationType = 4,
	buffType = 3,
	buffId = 1,
	name = 2,
	buffEffect = 5,
	effect = 6
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {
	name = 1
}

function lua_activity244_monster_buff.onLoad(json)
	lua_activity244_monster_buff.configList, lua_activity244_monster_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_monster_buff
