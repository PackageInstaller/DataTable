-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_endless_mode.lua

module("modules.configs.excel2json.lua_eliminate_battle_endless_mode", package.seeall)

local lua_eliminate_battle_endless_mode = {}
local fields = {
	powerUp3 = 8,
	skill2 = 5,
	powerUp1 = 4,
	skill4 = 9,
	powerUp4 = 10,
	skill5 = 11,
	skill3 = 7,
	powerUp2 = 6,
	skill1 = 3,
	id = 1,
	powerUp5 = 12,
	hpUp = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_eliminate_battle_endless_mode.onLoad(json)
	lua_eliminate_battle_endless_mode.configList, lua_eliminate_battle_endless_mode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_battle_endless_mode
