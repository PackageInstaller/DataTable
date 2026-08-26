-- chunkname: @modules/configs/excel2json/lua_card_heat.lua

module("modules.configs.excel2json.lua_card_heat", package.seeall)

local lua_card_heat = {}
local fields = {
	id = 1,
	desc = 3,
	descParam = 4,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_card_heat.onLoad(json)
	lua_card_heat.configList, lua_card_heat.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_card_heat
