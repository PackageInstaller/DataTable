-- chunkname: @modules/configs/excel2json/lua_activity147_goods.lua

module("modules.configs.excel2json.lua_activity147_goods", package.seeall)

local lua_activity147_goods = {}
local fields = {
	cost = 4,
	maxBuyCount = 5,
	product = 3,
	type = 6,
	id = 2,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity147_goods.onLoad(json)
	lua_activity147_goods.configList, lua_activity147_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity147_goods
