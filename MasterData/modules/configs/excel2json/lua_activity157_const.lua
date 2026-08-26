-- chunkname: @modules/configs/excel2json/lua_activity157_const.lua

module("modules.configs.excel2json.lua_activity157_const", package.seeall)

local lua_activity157_const = {}
local fields = {
	id = 2,
	value = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity157_const.onLoad(json)
	lua_activity157_const.configList, lua_activity157_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity157_const
