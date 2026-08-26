-- chunkname: @modules/configs/excel2json/lua_activity121_note.lua

module("modules.configs.excel2json.lua_activity121_note", package.seeall)

local lua_activity121_note = {}
local fields = {
	name = 3,
	unlockType = 4,
	noteId = 1,
	fightId = 6,
	desc = 7,
	content = 8,
	activityId = 2,
	episodeId = 5
}
local primaryKey = {
	"noteId",
	"activityId"
}
local mlStringKey = {
	name = 1,
	content = 3,
	desc = 2
}

function lua_activity121_note.onLoad(json)
	lua_activity121_note.configList, lua_activity121_note.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity121_note
