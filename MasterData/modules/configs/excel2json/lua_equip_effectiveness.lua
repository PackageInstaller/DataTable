-- chunkname: @modules/configs/excel2json/lua_equip_effectiveness.lua

module("modules.configs.excel2json.lua_equip_effectiveness", package.seeall)

local lua_equip_effectiveness = {}
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

function lua_equip_effectiveness.onLoad(json)
	lua_equip_effectiveness.configList, lua_equip_effectiveness.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_equip_effectiveness
