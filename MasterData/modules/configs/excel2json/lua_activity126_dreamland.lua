-- chunkname: @modules/configs/excel2json/lua_activity126_dreamland.lua

module("modules.configs.excel2json.lua_activity126_dreamland", package.seeall)

local lua_activity126_dreamland = {}
local fields = {
	indicator = 5,
	num = 6,
	dreamCards = 7,
	battleIds = 8,
	id = 1,
	cardSkill = 4,
	activityId = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity126_dreamland.onLoad(json)
	lua_activity126_dreamland.configList, lua_activity126_dreamland.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity126_dreamland
