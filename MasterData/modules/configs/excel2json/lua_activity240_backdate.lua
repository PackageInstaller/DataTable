-- chunkname: @modules/configs/excel2json/lua_activity240_backdate.lua

module("modules.configs.excel2json.lua_activity240_backdate", package.seeall)

local lua_activity240_backdate = {}
local fields = {
	activityId = 1,
	cost = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity240_backdate.onLoad(json)
	lua_activity240_backdate.configList, lua_activity240_backdate.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity240_backdate
