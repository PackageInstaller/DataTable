-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_dialog_style.lua

module("modules.configs.excel2json.lua_v2a4_warmup_dialog_style", package.seeall)

local lua_v2a4_warmup_dialog_style = {}
local fields = {
	id = 1,
	fontColor = 3,
	className = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_v2a4_warmup_dialog_style.onLoad(json)
	lua_v2a4_warmup_dialog_style.configList, lua_v2a4_warmup_dialog_style.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v2a4_warmup_dialog_style
