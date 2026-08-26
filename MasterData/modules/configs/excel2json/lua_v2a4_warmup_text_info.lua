-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_text_info.lua

module("modules.configs.excel2json.lua_v2a4_warmup_text_info", package.seeall)

local lua_v2a4_warmup_text_info = {}
local fields = {
	id = 1,
	name = 2,
	value = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value = 2,
	name = 1
}

function lua_v2a4_warmup_text_info.onLoad(json)
	lua_v2a4_warmup_text_info.configList, lua_v2a4_warmup_text_info.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v2a4_warmup_text_info
