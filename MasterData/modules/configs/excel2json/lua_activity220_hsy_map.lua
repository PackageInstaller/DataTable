-- chunkname: @modules/configs/excel2json/lua_activity220_hsy_map.lua

module("modules.configs.excel2json.lua_activity220_hsy_map", package.seeall)

local lua_activity220_hsy_map = {}
local fields = {
	rolepos = 5,
	endpos = 6,
	enemy2Bpos = 8,
	mapid = 3,
	id = 2,
	resouce = 4,
	activityId = 1,
	enemy2Apos = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity220_hsy_map.onLoad(json)
	lua_activity220_hsy_map.configList, lua_activity220_hsy_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_hsy_map
