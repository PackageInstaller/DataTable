-- chunkname: @modules/configs/excel2json/lua_activity169.lua

module("modules.configs.excel2json.lua_activity169", package.seeall)

local lua_activity169 = {}
local fields = {
	activityId = 1,
	heroIds = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity169.onLoad(json)
	lua_activity169.configList, lua_activity169.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity169
