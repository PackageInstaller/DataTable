-- chunkname: @modules/configs/excel2json/lua_turnback_drop.lua

module("modules.configs.excel2json.lua_turnback_drop", package.seeall)

local lua_turnback_drop = {}
local fields = {
	listenerParam = 5,
	name = 3,
	showTxt = 8,
	type = 4,
	id = 1,
	picPath = 7,
	jumpId = 6,
	level = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	showTxt = 1
}

function lua_turnback_drop.onLoad(json)
	lua_turnback_drop.configList, lua_turnback_drop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_turnback_drop
