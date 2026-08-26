-- chunkname: @modules/configs/excel2json/lua_rouge2_event.lua

module("modules.configs.excel2json.lua_rouge2_event", package.seeall)

local lua_rouge2_event = {}
local fields = {
	isHighQuality = 10,
	name = 4,
	type = 2,
	image = 3,
	desc = 6,
	advantageAttribute = 9,
	id = 1,
	mainDesc = 7,
	eventParam = 8,
	nameEn = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 3,
	name = 1,
	nameEn = 2
}

function lua_rouge2_event.onLoad(json)
	lua_rouge2_event.configList, lua_rouge2_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_event
