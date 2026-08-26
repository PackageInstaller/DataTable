-- chunkname: @modules/configs/excel2json/lua_activity196.lua

module("modules.configs.excel2json.lua_activity196", package.seeall)

local lua_activity196 = {}
local fields = {
	id = 1,
	code = 3,
	activityId = 2,
	bonus = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity196.onLoad(json)
	lua_activity196.configList, lua_activity196.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity196
