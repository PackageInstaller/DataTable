-- chunkname: @modules/configs/excel2json/lua_character_destiny_slots.lua

module("modules.configs.excel2json.lua_character_destiny_slots", package.seeall)

local lua_character_destiny_slots = {}
local fields = {
	node = 3,
	effect = 5,
	consume = 4,
	stage = 2,
	slotsId = 1
}
local primaryKey = {
	"slotsId",
	"stage",
	"node"
}
local mlStringKey = {}

function lua_character_destiny_slots.onLoad(json)
	lua_character_destiny_slots.configList, lua_character_destiny_slots.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_destiny_slots
