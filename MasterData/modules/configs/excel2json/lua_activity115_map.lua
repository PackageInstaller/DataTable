-- chunkname: @modules/configs/excel2json/lua_activity115_map.lua

module("modules.configs.excel2json.lua_activity115_map", package.seeall)

local lua_activity115_map = {}
local fields = {
	bgPath = 6,
	height = 4,
	ambientAudio = 5,
	activityId = 1,
	objects = 9,
	offset = 7,
	tilebase = 8,
	id = 2,
	width = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity115_map.onLoad(json)
	lua_activity115_map.configList, lua_activity115_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity115_map
