-- chunkname: @modules/configs/excel2json/lua_activity142_collection.lua

module("modules.configs.excel2json.lua_activity142_collection", package.seeall)

local lua_activity142_collection = {}
local fields = {
	name = 3,
	nameen = 4,
	id = 2,
	icon = 6,
	activityId = 1,
	desc = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity142_collection.onLoad(json)
	lua_activity142_collection.configList, lua_activity142_collection.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity142_collection
