-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_level.lua

module("modules.configs.excel2json.lua_v2a4_warmup_level", package.seeall)

local lua_v2a4_warmup_level = {}
local fields = {
	askCount = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_v2a4_warmup_level.onLoad(json)
	lua_v2a4_warmup_level.configList, lua_v2a4_warmup_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v2a4_warmup_level
