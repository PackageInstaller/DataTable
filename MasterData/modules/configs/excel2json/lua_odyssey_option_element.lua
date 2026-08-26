-- chunkname: @modules/configs/excel2json/lua_odyssey_option_element.lua

module("modules.configs.excel2json.lua_odyssey_option_element", package.seeall)

local lua_odyssey_option_element = {}
local fields = {
	title = 3,
	optionList = 2,
	id = 1,
	image = 4,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_odyssey_option_element.onLoad(json)
	lua_odyssey_option_element.configList, lua_odyssey_option_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_option_element
