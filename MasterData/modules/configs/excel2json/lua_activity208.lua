-- chunkname: @modules/configs/excel2json/lua_activity208.lua

module("modules.configs.excel2json.lua_activity208", package.seeall)

local lua_activity208 = {}
local fields = {
	id = 2,
	isAllBonus = 3,
	activityId = 1,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity208.onLoad(json)
	lua_activity208.configList, lua_activity208.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity208
