-- chunkname: @modules/configs/excel2json/lua_racing_item.lua

module("modules.configs.excel2json.lua_racing_item", package.seeall)

local lua_racing_item = {}
local fields = {
	id = 1,
	name = 2,
	effect = 3,
	icon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_racing_item.onLoad(json)
	lua_racing_item.configList, lua_racing_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_racing_item
