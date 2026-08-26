-- chunkname: @modules/configs/excel2json/lua_auto_fight_tool_const.lua

module("modules.configs.excel2json.lua_auto_fight_tool_const", package.seeall)

local lua_auto_fight_tool_const = {}
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

function lua_auto_fight_tool_const.onLoad(json)
	lua_auto_fight_tool_const.configList, lua_auto_fight_tool_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_fight_tool_const
