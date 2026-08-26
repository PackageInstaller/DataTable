-- chunkname: @modules/configs/excel2json/lua_tower_compose_part.lua

module("modules.configs.excel2json.lua_tower_compose_part", package.seeall)

local lua_tower_compose_part = {}
local fields = {
	bossId = 2,
	partLevel = 10,
	partDesc = 11,
	isUnlock = 12,
	bossPointBase = 4,
	slotPart = 9,
	partName = 7,
	slot = 3,
	partEffects = 6,
	id = 1,
	icon = 8,
	bossPointAdd = 5
}
local primaryKey = {
	"id",
	"bossId"
}
local mlStringKey = {
	partName = 1,
	partDesc = 2
}

function lua_tower_compose_part.onLoad(json)
	lua_tower_compose_part.configList, lua_tower_compose_part.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_part
