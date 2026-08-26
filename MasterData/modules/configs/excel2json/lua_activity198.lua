-- chunkname: @modules/configs/excel2json/lua_activity198.lua

module("modules.configs.excel2json.lua_activity198", package.seeall)

local lua_activity198 = {}
local fields = {
	activityId = 1,
	num = 3,
	skinIds = 2,
	bonus = 4
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity198.onLoad(json)
	lua_activity198.configList, lua_activity198.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity198
