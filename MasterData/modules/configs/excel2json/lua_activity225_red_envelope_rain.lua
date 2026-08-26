-- chunkname: @modules/configs/excel2json/lua_activity225_red_envelope_rain.lua

module("modules.configs.excel2json.lua_activity225_red_envelope_rain", package.seeall)

local lua_activity225_red_envelope_rain = {}
local fields = {
	id = 2,
	endTime = 4,
	activityId = 1,
	startTime = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity225_red_envelope_rain.onLoad(json)
	lua_activity225_red_envelope_rain.configList, lua_activity225_red_envelope_rain.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity225_red_envelope_rain
