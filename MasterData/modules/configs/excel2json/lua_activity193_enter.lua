-- chunkname: @modules/configs/excel2json/lua_activity193_enter.lua

module("modules.configs.excel2json.lua_activity193_enter", package.seeall)

local lua_activity193_enter = {}
local fields = {
	times = 6,
	name = 2,
	id = 1,
	icon = 5,
	targetDesc = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	targetDesc = 3,
	desc = 2
}

function lua_activity193_enter.onLoad(json)
	lua_activity193_enter.configList, lua_activity193_enter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity193_enter
