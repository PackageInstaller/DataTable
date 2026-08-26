-- chunkname: @modules/configs/excel2json/lua_fight_cure_order.lua

module("modules.configs.excel2json.lua_fight_cure_order", package.seeall)

local lua_fight_cure_order = {}
local fields = {
	id = 1,
	order = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_cure_order.onLoad(json)
	lua_fight_cure_order.configList, lua_fight_cure_order.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_cure_order
