-- chunkname: @modules/configs/excel2json/lua_activity159.lua

module("modules.configs.excel2json.lua_activity159", package.seeall)

local lua_activity159 = {}
local fields = {
	bonus = 3,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {}

function lua_activity159.onLoad(json)
	lua_activity159.configList, lua_activity159.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity159
