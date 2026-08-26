-- chunkname: @modules/configs/excel2json/lua_activity179_beat.lua

module("modules.configs.excel2json.lua_activity179_beat", package.seeall)

local lua_activity179_beat = {}
local fields = {
	targetId = 3,
	time = 6,
	noteGroupId = 4,
	id = 2,
	resouce = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity179_beat.onLoad(json)
	lua_activity179_beat.configList, lua_activity179_beat.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity179_beat
