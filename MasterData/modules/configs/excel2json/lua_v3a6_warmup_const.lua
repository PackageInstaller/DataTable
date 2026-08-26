-- chunkname: @modules/configs/excel2json/lua_v3a6_warmup_const.lua

module("modules.configs.excel2json.lua_v3a6_warmup_const", package.seeall)

local lua_v3a6_warmup_const = {}
local fields = {
	id = 1,
	numValue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_v3a6_warmup_const.onLoad(json)
	lua_v3a6_warmup_const.configList, lua_v3a6_warmup_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v3a6_warmup_const
