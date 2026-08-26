-- chunkname: @modules/configs/excel2json/lua_talent_upgrade_item.lua

module("modules.configs.excel2json.lua_talent_upgrade_item", package.seeall)

local lua_talent_upgrade_item = {}
local fields = {
	effect = 8,
	name = 2,
	useDesc = 5,
	useTitle = 7,
	id = 1,
	icon = 3,
	expireSeconds = 4,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	useTitle = 4,
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_talent_upgrade_item.onLoad(json)
	lua_talent_upgrade_item.configList, lua_talent_upgrade_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_talent_upgrade_item
