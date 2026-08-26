-- chunkname: @modules/configs/excel2json/lua_activity105.lua

module("modules.configs.excel2json.lua_activity105", package.seeall)

local lua_activity105 = {}
local fields = {
	activityId = 1,
	pv = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity105.onLoad(json)
	lua_activity105.configList, lua_activity105.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity105
