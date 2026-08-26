-- chunkname: @modules/configs/excel2json/lua_fight_xcjl_const.lua

module("modules.configs.excel2json.lua_fight_xcjl_const", package.seeall)

local lua_fight_xcjl_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value2 = 1
}

function lua_fight_xcjl_const.onLoad(json)
	lua_fight_xcjl_const.configList, lua_fight_xcjl_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_xcjl_const
