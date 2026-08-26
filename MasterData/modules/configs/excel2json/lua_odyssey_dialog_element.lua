-- chunkname: @modules/configs/excel2json/lua_odyssey_dialog_element.lua

module("modules.configs.excel2json.lua_odyssey_dialog_element", package.seeall)

local lua_odyssey_dialog_element = {}
local fields = {
	stepId = 2,
	name = 6,
	nextStep = 3,
	optionList = 5,
	id = 1,
	picture = 4,
	desc = 7
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_odyssey_dialog_element.onLoad(json)
	lua_odyssey_dialog_element.configList, lua_odyssey_dialog_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_dialog_element
