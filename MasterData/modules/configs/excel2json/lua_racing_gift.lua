-- chunkname: @modules/configs/excel2json/lua_racing_gift.lua

module("modules.configs.excel2json.lua_racing_gift", package.seeall)

local lua_racing_gift = {}
local fields = {
	cost = 11,
	name = 8,
	order = 5,
	shortDesc = 9,
	group = 4,
	effect = 6,
	desc = 10,
	gift_point = 1,
	icon = 7,
	activityId = 3,
	level = 2
}
local primaryKey = {
	"gift_point",
	"level"
}
local mlStringKey = {
	shortDesc = 2,
	name = 1,
	desc = 3
}

function lua_racing_gift.onLoad(json)
	lua_racing_gift.configList, lua_racing_gift.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_racing_gift
