-- chunkname: @modules/configs/excel2json/lua_track_coin_string.lua

module("modules.configs.excel2json.lua_track_coin_string", package.seeall)

local lua_track_coin_string = {}
local fields = {
	elementId = 3,
	space = 5,
	point = 4,
	traceId = 1,
	isOn = 6,
	coinStringId = 2
}
local primaryKey = {
	"traceId",
	"coinStringId"
}
local mlStringKey = {}

function lua_track_coin_string.onLoad(json)
	lua_track_coin_string.configList, lua_track_coin_string.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_track_coin_string
