-- chunkname: @modules/configs/excel2json/lua_activity179_note.lua

module("modules.configs.excel2json.lua_activity179_note", package.seeall)

local lua_activity179_note = {}
local fields = {
	musicId = 2,
	time = 5,
	eventName = 4,
	id = 1,
	buttonId = 3
}
local primaryKey = {
	"id",
	"musicId"
}
local mlStringKey = {}

function lua_activity179_note.onLoad(json)
	lua_activity179_note.configList, lua_activity179_note.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity179_note
