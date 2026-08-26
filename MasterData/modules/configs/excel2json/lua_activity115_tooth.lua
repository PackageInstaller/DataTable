-- chunkname: @modules/configs/excel2json/lua_activity115_tooth.lua

module("modules.configs.excel2json.lua_activity115_tooth", package.seeall)

local lua_activity115_tooth = {}
local fields = {
	story = 5,
	name = 3,
	prefab = 7,
	id = 2,
	icon = 6,
	activityId = 1,
	desc = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity115_tooth.onLoad(json)
	lua_activity115_tooth.configList, lua_activity115_tooth.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity115_tooth
