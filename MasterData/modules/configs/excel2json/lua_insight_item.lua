-- chunkname: @modules/configs/excel2json/lua_insight_item.lua

module("modules.configs.excel2json.lua_insight_item", package.seeall)

local lua_insight_item = {}
local fields = {
	heroRares = 5,
	name = 2,
	useDesc = 8,
	heroRank = 6,
	desc = 9,
	effect = 11,
	rare = 4,
	expireHours = 7,
	sources = 12,
	useTitle = 10,
	id = 1,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	useTitle = 4,
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_insight_item.onLoad(json)
	lua_insight_item.configList, lua_insight_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_insight_item
