-- chunkname: @modules/configs/excel2json/lua_activity199.lua

module("modules.configs.excel2json.lua_activity199", package.seeall)

local lua_activity199 = {}
local fields = {
	activityId = 1,
	heroIds = 2
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity199.onLoad(json)
	lua_activity199.configList, lua_activity199.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity199
