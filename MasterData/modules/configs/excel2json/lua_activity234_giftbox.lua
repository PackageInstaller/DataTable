-- chunkname: @modules/configs/excel2json/lua_activity234_giftbox.lua

module("modules.configs.excel2json.lua_activity234_giftbox", package.seeall)

local lua_activity234_giftbox = {}
local fields = {
	iconsmall = 5,
	name = 3,
	type = 2,
	id = 1,
	icon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity234_giftbox.onLoad(json)
	lua_activity234_giftbox.configList, lua_activity234_giftbox.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity234_giftbox
