-- chunkname: @modules/configs/excel2json/lua_activity181_boxlist.lua

module("modules.configs.excel2json.lua_activity181_boxlist", package.seeall)

local lua_activity181_boxlist = {}
local fields = {
	id = 2,
	bonusWeight = 4,
	activityId = 1,
	bonus = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity181_boxlist.onLoad(json)
	lua_activity181_boxlist.configList, lua_activity181_boxlist.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity181_boxlist
