-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_monster_group.lua

module("modules.configs.excel2json.lua_activity220_hedone_monster_group", package.seeall)

local lua_activity220_hedone_monster_group = {}
local fields = {
	id = 1,
	monsters = 5,
	type = 2,
	baseAttrFactor = 4,
	weight = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity220_hedone_monster_group.onLoad(json)
	lua_activity220_hedone_monster_group.configList, lua_activity220_hedone_monster_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_hedone_monster_group
