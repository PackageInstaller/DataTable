-- chunkname: @modules/configs/excel2json/lua_talent_effectiveness.lua

module("modules.configs.excel2json.lua_talent_effectiveness", package.seeall)

local lua_talent_effectiveness = {}
local fields = {
	sr = 3,
	ssr = 2,
	r = 4,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_talent_effectiveness.onLoad(json)
	lua_talent_effectiveness.configList, lua_talent_effectiveness.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_talent_effectiveness
