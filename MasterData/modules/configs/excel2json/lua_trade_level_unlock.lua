-- chunkname: @modules/configs/excel2json/lua_trade_level_unlock.lua

module("modules.configs.excel2json.lua_trade_level_unlock", package.seeall)

local lua_trade_level_unlock = {}
local fields = {
	itemType = 7,
	name = 2,
	levelupDes = 5,
	type = 4,
	id = 1,
	icon = 3,
	sort = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	levelupDes = 2,
	name = 1
}

function lua_trade_level_unlock.onLoad(json)
	lua_trade_level_unlock.configList, lua_trade_level_unlock.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_trade_level_unlock
