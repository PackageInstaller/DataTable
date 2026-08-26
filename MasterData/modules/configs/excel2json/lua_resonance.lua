-- chunkname: @modules/configs/excel2json/lua_resonance.lua

module("modules.configs.excel2json.lua_resonance", package.seeall)

local lua_resonance = {}
local fields = {
	desc = 3,
	name = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_resonance.onLoad(json)
	lua_resonance.configList, lua_resonance.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_resonance
