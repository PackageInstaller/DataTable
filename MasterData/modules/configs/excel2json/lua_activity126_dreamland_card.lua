-- chunkname: @modules/configs/excel2json/lua_activity126_dreamland_card.lua

module("modules.configs.excel2json.lua_activity126_dreamland_card", package.seeall)

local lua_activity126_dreamland_card = {}
local fields = {
	id = 1,
	desc = 4,
	activityId = 2,
	skillId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity126_dreamland_card.onLoad(json)
	lua_activity126_dreamland_card.configList, lua_activity126_dreamland_card.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity126_dreamland_card
