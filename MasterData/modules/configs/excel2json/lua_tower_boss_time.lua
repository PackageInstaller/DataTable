-- chunkname: @modules/configs/excel2json/lua_tower_boss_time.lua

module("modules.configs.excel2json.lua_tower_boss_time", package.seeall)

local lua_tower_boss_time = {}
local fields = {
	taskEndTime = 7,
	isOnline = 8,
	isPermanent = 3,
	endTime = 5,
	startTime = 4,
	taskGroupId = 6,
	round = 2,
	towerId = 1
}
local primaryKey = {
	"towerId",
	"round"
}
local mlStringKey = {}

function lua_tower_boss_time.onLoad(json)
	lua_tower_boss_time.configList, lua_tower_boss_time.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_boss_time
