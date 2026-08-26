-- chunkname: @modules/configs/excel2json/lua_rogue_event_drama_choice.lua

module("modules.configs.excel2json.lua_rogue_event_drama_choice", package.seeall)

local lua_rogue_event_drama_choice = {}
local fields = {
	dialogId = 7,
	event = 9,
	collection = 10,
	type = 2,
	group = 3,
	title = 5,
	condition = 4,
	desc = 6,
	id = 1,
	icon = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_rogue_event_drama_choice.onLoad(json)
	lua_rogue_event_drama_choice.configList, lua_rogue_event_drama_choice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_event_drama_choice
