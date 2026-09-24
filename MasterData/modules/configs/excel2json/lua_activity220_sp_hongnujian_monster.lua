-- chunkname: @modules/configs/excel2json/lua_activity220_sp_hongnujian_monster.lua

module("modules.configs.excel2json.lua_activity220_sp_hongnujian_monster", package.seeall)

local lua_activity220_sp_hongnujian_monster = {}
local fields = {
	life = 6,
	radius = 12,
	waveTime = 4,
	type = 8,
	group = 3,
	pos = 5,
	move = 11,
	speed = 9,
	res = 10,
	atk = 7,
	id = 1,
	monster = 2
}
local primaryKey = {
	"id",
	"monster"
}
local mlStringKey = {}

function lua_activity220_sp_hongnujian_monster.onLoad(json)
	lua_activity220_sp_hongnujian_monster.configList, lua_activity220_sp_hongnujian_monster.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_sp_hongnujian_monster
