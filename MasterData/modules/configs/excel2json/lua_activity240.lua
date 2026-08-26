-- chunkname: @modules/configs/excel2json/lua_activity240.lua

module("modules.configs.excel2json.lua_activity240", package.seeall)

local lua_activity240 = {}
local fields = {
	id = 2,
	isnotPush = 4,
	activityId = 1,
	bonus = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity240.onLoad(json)
	lua_activity240.configList, lua_activity240.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity240
