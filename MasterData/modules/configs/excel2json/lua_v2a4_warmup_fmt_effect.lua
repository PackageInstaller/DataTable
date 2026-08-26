-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_fmt_effect.lua

module("modules.configs.excel2json.lua_v2a4_warmup_fmt_effect", package.seeall)

local lua_v2a4_warmup_fmt_effect = {}
local fields = {
	id = 1,
	args = 3,
	handler = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_v2a4_warmup_fmt_effect.onLoad(json)
	lua_v2a4_warmup_fmt_effect.configList, lua_v2a4_warmup_fmt_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v2a4_warmup_fmt_effect
