-- chunkname: @modules/configs/excel2json/lua_track_placed_element.lua

module("modules.configs.excel2json.lua_track_placed_element", package.seeall)

local lua_track_placed_element = {}
local fields = {
	elementId = 3,
	isOn = 6,
	distance = 5,
	lane = 4,
	traceId = 1,
	elementUid = 2
}
local primaryKey = {
	"traceId",
	"elementUid"
}
local mlStringKey = {}

function lua_track_placed_element.onLoad(json)
	lua_track_placed_element.configList, lua_track_placed_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_track_placed_element
