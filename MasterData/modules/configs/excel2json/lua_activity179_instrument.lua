-- chunkname: @modules/configs/excel2json/lua_activity179_instrument.lua

module("modules.configs.excel2json.lua_activity179_instrument", package.seeall)

local lua_activity179_instrument = {}
local fields = {
	id = 1,
	name = 2,
	switch = 3,
	icon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity179_instrument.onLoad(json)
	lua_activity179_instrument.configList, lua_activity179_instrument.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity179_instrument
