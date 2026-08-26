-- chunkname: @modules/configs/excel2json/lua_rouge_item_static_desc.lua

module("modules.configs.excel2json.lua_rouge_item_static_desc", package.seeall)

local lua_rouge_item_static_desc = {}
local fields = {
	item1_attr = 3,
	id = 1,
	item3 = 6,
	item2_attr = 5,
	item2 = 4,
	item3_attr = 7,
	item1 = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_item_static_desc.onLoad(json)
	lua_rouge_item_static_desc.configList, lua_rouge_item_static_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_item_static_desc
