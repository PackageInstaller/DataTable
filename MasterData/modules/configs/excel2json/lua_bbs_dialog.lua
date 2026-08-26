-- chunkname: @modules/configs/excel2json/lua_bbs_dialog.lua

module("modules.configs.excel2json.lua_bbs_dialog", package.seeall)

local lua_bbs_dialog = {}
local fields = {
	audioId = 4,
	text = 5,
	tipsDir = 6,
	delay = 7,
	id = 1,
	icon = 3,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {
	text = 1
}

function lua_bbs_dialog.onLoad(json)
	lua_bbs_dialog.configList, lua_bbs_dialog.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bbs_dialog
