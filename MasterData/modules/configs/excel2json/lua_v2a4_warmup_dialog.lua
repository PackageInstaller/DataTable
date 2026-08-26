-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_dialog.lua

module("modules.configs.excel2json.lua_v2a4_warmup_dialog", package.seeall)

local lua_v2a4_warmup_dialog = {}
local fields = {
	fmt1 = 5,
	fmt3 = 7,
	fmt2 = 6,
	nextId = 4,
	group = 2,
	desc = 3,
	id = 1,
	fmt5 = 9,
	fmt4 = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_v2a4_warmup_dialog.onLoad(json)
	lua_v2a4_warmup_dialog.configList, lua_v2a4_warmup_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v2a4_warmup_dialog
