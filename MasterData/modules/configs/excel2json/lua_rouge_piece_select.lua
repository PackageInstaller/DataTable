-- chunkname: @modules/configs/excel2json/lua_rouge_piece_select.lua

module("modules.configs.excel2json.lua_rouge_piece_select", package.seeall)

local lua_rouge_piece_select = {}
local fields = {
	activeParam = 5,
	display = 11,
	triggerParam = 10,
	unlockParam = 3,
	id = 1,
	title = 6,
	content = 7,
	triggerType = 9,
	unlockType = 2,
	activeType = 4,
	talkDesc = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	talkDesc = 3,
	title = 1,
	content = 2
}

function lua_rouge_piece_select.onLoad(json)
	lua_rouge_piece_select.configList, lua_rouge_piece_select.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_piece_select
