-- chunkname: @modules/configs/excel2json/lua_tower_limited_time.lua

module("modules.configs.excel2json.lua_tower_limited_time", package.seeall)

local lua_tower_limited_time = {}
local fields = {
	bossPool = 4,
	isOnline = 6,
	endTime = 3,
	season = 1,
	taskGroupId = 5,
	startTime = 2
}
local primaryKey = {
	"season"
}
local mlStringKey = {}

function lua_tower_limited_time.onLoad(json)
	lua_tower_limited_time.configList, lua_tower_limited_time.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_limited_time
