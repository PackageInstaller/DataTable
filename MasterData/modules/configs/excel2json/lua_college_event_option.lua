-- chunkname: @modules/configs/excel2json/lua_college_event_option.lua

module("modules.configs.excel2json.lua_college_event_option", package.seeall)

local lua_college_event_option = {}
local fields = {
	id = 1,
	label = 2,
	description = 3,
	optionType = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	description = 2,
	label = 1
}

function lua_college_event_option.onLoad(json)
	lua_college_event_option.configList, lua_college_event_option.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_event_option
