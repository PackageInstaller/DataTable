-- chunkname: @modules/configs/excel2json/lua_arcade_room.lua

module("modules.configs.excel2json.lua_arcade_room", package.seeall)

local lua_arcade_room = {}
local fields = {
	dropMethod = 3,
	initMonster = 8,
	initFloor = 10,
	roomType = 2,
	initInteractive = 9,
	monsterwaves = 5,
	spMonster = 7,
	waveInterval = 6,
	monsterGroupIds = 4,
	skills = 12,
	id = 1,
	nodePortalCoordinates = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_room.onLoad(json)
	lua_arcade_room.configList, lua_arcade_room.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_room
