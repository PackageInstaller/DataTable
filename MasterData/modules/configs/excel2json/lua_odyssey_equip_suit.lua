-- chunkname: @modules/configs/excel2json/lua_odyssey_equip_suit.lua

module("modules.configs.excel2json.lua_odyssey_equip_suit", package.seeall)

local lua_odyssey_equip_suit = {}
local fields = {
	id = 1,
	name = 2,
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

function lua_odyssey_equip_suit.onLoad(json)
	lua_odyssey_equip_suit.configList, lua_odyssey_equip_suit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_equip_suit
