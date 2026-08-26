-- chunkname: @modules/configs/excel2json/lua_rouge2_piece_select.lua

module("modules.configs.excel2json.lua_rouge2_piece_select", package.seeall)

local lua_rouge2_piece_select = {}
local fields = {
	check = 4,
	descBigSuccess = 11,
	afterSelect = 5,
	descSuccess = 9,
	checkId = 6,
	title = 7,
	content = 8,
	unlock = 2,
	descLose = 10,
	triggerType = 12,
	triggerParam = 13,
	display = 14,
	id = 1,
	active = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	title = 1
}

function lua_rouge2_piece_select.onLoad(json)
	lua_rouge2_piece_select.configList, lua_rouge2_piece_select.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_piece_select
