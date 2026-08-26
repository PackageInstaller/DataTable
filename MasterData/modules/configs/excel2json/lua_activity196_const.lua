-- chunkname: @modules/configs/excel2json/lua_activity196_const.lua

module("modules.configs.excel2json.lua_activity196_const", package.seeall)

local lua_activity196_const = {}
local fields = {
	activityId = 1,
	time = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity196_const.onLoad(json)
	lua_activity196_const.configList, lua_activity196_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity196_const
