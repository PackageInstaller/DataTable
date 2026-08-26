-- chunkname: @modules/configs/excel2json/lua_rogue_collection.lua

module("modules.configs.excel2json.lua_rogue_collection", package.seeall)

local lua_rogue_collection = {}
local fields = {
	skills = 12,
	name = 2,
	group = 10,
	type = 3,
	eventGroupWeights = 17,
	dropGroupWeights = 19,
	unlockTask = 20,
	desc = 13,
	inHandBook = 21,
	statetype = 8,
	icon = 9,
	spdesc = 14,
	attr = 11,
	shopWeights = 18,
	holeNum = 6,
	showRare = 5,
	rare = 4,
	unique = 7,
	heartbeatRange = 15,
	eventWeights = 16,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	spdesc = 3,
	desc = 2
}

function lua_rogue_collection.onLoad(json)
	lua_rogue_collection.configList, lua_rogue_collection.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_collection
