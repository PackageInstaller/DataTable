-- chunkname: @modules/configs/excel2json/lua_dungeon_jump.lua

module("modules.configs.excel2json.lua_dungeon_jump", package.seeall)

local lua_dungeon_jump = {}
local fields = {
	isflag = 7,
	celltype = 4,
	coord = 3,
	cellspecies = 6,
	id = 1,
	cellId = 2,
	evenid = 5
}
local primaryKey = {
	"id",
	"cellId"
}
local mlStringKey = {}

function lua_dungeon_jump.onLoad(json)
	lua_dungeon_jump.configList, lua_dungeon_jump.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dungeon_jump
