-- chunkname: @modules/configs/excel2json/lua_college_item.lua

module("modules.configs.excel2json.lua_college_item", package.seeall)

local lua_college_item = {}
local fields = {
	max = 5,
	name = 2,
	type = 6,
	id = 1,
	icon = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_college_item.onLoad(json)
	lua_college_item.configList, lua_college_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_item
