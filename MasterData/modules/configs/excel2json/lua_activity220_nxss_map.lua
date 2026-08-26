-- chunkname: @modules/configs/excel2json/lua_activity220_nxss_map.lua

module("modules.configs.excel2json.lua_activity220_nxss_map", package.seeall)

local lua_activity220_nxss_map = {}
local fields = {
	activityId = 1,
	height = 4,
	tilebase = 5,
	type = 7,
	id = 2,
	width = 3,
	desc = 6
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity220_nxss_map.onLoad(json)
	lua_activity220_nxss_map.configList, lua_activity220_nxss_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_nxss_map
