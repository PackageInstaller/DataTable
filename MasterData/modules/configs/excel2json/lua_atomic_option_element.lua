-- chunkname: @modules/configs/excel2json/lua_atomic_option_element.lua

module("modules.configs.excel2json.lua_atomic_option_element", package.seeall)

local lua_atomic_option_element = {}
local fields = {
	stepId = 2,
	image = 6,
	optionList = 4,
	id = 1,
	title = 5,
	nextStepId = 3,
	desc = 7
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_atomic_option_element.onLoad(json)
	lua_atomic_option_element.configList, lua_atomic_option_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_option_element
