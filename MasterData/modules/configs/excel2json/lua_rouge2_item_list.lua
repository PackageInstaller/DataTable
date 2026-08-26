-- chunkname: @modules/configs/excel2json/lua_rouge2_item_list.lua

module("modules.configs.excel2json.lua_rouge2_item_list", package.seeall)

local lua_rouge2_item_list = {}
local fields = {
	itemId = 2,
	unlockType = 4,
	conditionParam = 5,
	type = 3,
	id = 1,
	isHide = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_item_list.onLoad(json)
	lua_rouge2_item_list.configList, lua_rouge2_item_list.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_item_list
