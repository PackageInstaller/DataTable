-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_monster.lua

module("modules.configs.excel2json.lua_activity220_hedone_monster", package.seeall)

local lua_activity220_hedone_monster = {}
local fields = {
	showHp = 7,
	baseAttr = 2,
	exp = 6,
	moveSpeed = 5,
	id = 1,
	image = 3,
	scale = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity220_hedone_monster.onLoad(json)
	lua_activity220_hedone_monster.configList, lua_activity220_hedone_monster.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_hedone_monster
