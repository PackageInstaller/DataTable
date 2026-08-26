-- chunkname: @modules/configs/excel2json/lua_dialogue_chess_info.lua

module("modules.configs.excel2json.lua_dialogue_chess_info", package.seeall)

local lua_dialogue_chess_info = {}
local fields = {
	id = 2,
	res = 3,
	dialogueId = 1,
	pos = 4
}
local primaryKey = {
	"dialogueId",
	"id"
}
local mlStringKey = {}

function lua_dialogue_chess_info.onLoad(json)
	lua_dialogue_chess_info.configList, lua_dialogue_chess_info.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dialogue_chess_info
