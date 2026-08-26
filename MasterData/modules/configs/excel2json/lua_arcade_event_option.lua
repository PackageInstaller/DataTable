-- chunkname: @modules/configs/excel2json/lua_arcade_event_option.lua

module("modules.configs.excel2json.lua_arcade_event_option", package.seeall)

local lua_arcade_event_option = {}
local fields = {
	param = 5,
	descChange = 6,
	type = 2,
	id = 1,
	optionDesc = 3,
	condition = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	descChange = 2,
	optionDesc = 1
}

function lua_arcade_event_option.onLoad(json)
	lua_arcade_event_option.configList, lua_arcade_event_option.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_event_option
