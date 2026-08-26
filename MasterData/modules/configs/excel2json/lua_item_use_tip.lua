-- chunkname: @modules/configs/excel2json/lua_item_use_tip.lua

module("modules.configs.excel2json.lua_item_use_tip", package.seeall)

local lua_item_use_tip = {}
local fields = {
	jumpId = 4,
	priority = 2,
	checkParam = 7,
	type = 3,
	id = 1,
	descParam = 6,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_item_use_tip.onLoad(json)
	lua_item_use_tip.configList, lua_item_use_tip.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_item_use_tip
