-- chunkname: @modules/configs/excel2json/lua_activity189.lua

module("modules.configs.excel2json.lua_activity189", package.seeall)

local lua_activity189 = {}
local fields = {
	id = 1,
	activityId = 2,
	bonus = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity189.onLoad(json)
	lua_activity189.configList, lua_activity189.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity189
