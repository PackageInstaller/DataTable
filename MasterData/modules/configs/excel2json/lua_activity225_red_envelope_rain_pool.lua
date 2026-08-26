-- chunkname: @modules/configs/excel2json/lua_activity225_red_envelope_rain_pool.lua

module("modules.configs.excel2json.lua_activity225_red_envelope_rain_pool", package.seeall)

local lua_activity225_red_envelope_rain_pool = {}
local fields = {
	source = 1
}
local primaryKey = {}
local mlStringKey = {}

function lua_activity225_red_envelope_rain_pool.onLoad(json)
	lua_activity225_red_envelope_rain_pool.configList, lua_activity225_red_envelope_rain_pool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity225_red_envelope_rain_pool
