-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_dialog_type.lua

module("modules.configs.excel2json.lua_v2a4_warmup_dialog_type", package.seeall)

local lua_v2a4_warmup_dialog_type = {}
local fields = {
	id = 1,
	style = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_v2a4_warmup_dialog_type.onLoad(json)
	lua_v2a4_warmup_dialog_type.configList, lua_v2a4_warmup_dialog_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v2a4_warmup_dialog_type
