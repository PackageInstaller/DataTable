-- chunkname: @modules/configs/excel2json/lua_item_use.lua

module("modules.configs.excel2json.lua_item_use", package.seeall)

local lua_item_use = {}
local fields = {
	id = 1,
	name = 2,
	use_max = 4,
	useType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_item_use.onLoad(json)
	lua_item_use.configList, lua_item_use.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_item_use
