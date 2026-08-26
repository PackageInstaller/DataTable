-- chunkname: @modules/configs/excel2json/lua_activity168_item.lua

module("modules.configs.excel2json.lua_activity168_item", package.seeall)

local lua_activity168_item = {}
local fields = {
	itemId = 2,
	name = 3,
	compostType = 5,
	type = 4,
	weight = 6,
	icon = 7,
	activityId = 1,
	desc = 8
}
local primaryKey = {
	"activityId",
	"itemId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity168_item.onLoad(json)
	lua_activity168_item.configList, lua_activity168_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity168_item
