-- chunkname: @modules/configs/excel2json/lua_musicgame_note.lua

module("modules.configs.excel2json.lua_musicgame_note", package.seeall)

local lua_musicgame_note = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3,
	audioId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_musicgame_note.onLoad(json)
	lua_musicgame_note.configList, lua_musicgame_note.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_musicgame_note
