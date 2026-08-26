-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_const_mlstring.lua

module("modules.configs.excel2json.lua_v2a4_warmup_const_mlstring", package.seeall)

local lua_v2a4_warmup_const_mlstring = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value = 1
}

function lua_v2a4_warmup_const_mlstring.onLoad(json)
	lua_v2a4_warmup_const_mlstring.configList, lua_v2a4_warmup_const_mlstring.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v2a4_warmup_const_mlstring
