-- chunkname: @modules/configs/excel2json/lua_fight_assembled_monster.lua

module("modules.configs.excel2json.lua_fight_assembled_monster", package.seeall)

local lua_fight_assembled_monster = {}
local fields = {
	clickIndex = 6,
	virtualStance = 3,
	part = 2,
	hpPos = 8,
	id = 1,
	virtualSpineSize = 5,
	selectPos = 7,
	virtualSpinePos = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_assembled_monster.onLoad(json)
	lua_fight_assembled_monster.configList, lua_fight_assembled_monster.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_assembled_monster
