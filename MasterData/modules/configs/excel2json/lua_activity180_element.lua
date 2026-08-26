-- chunkname: @modules/configs/excel2json/lua_activity180_element.lua

module("modules.configs.excel2json.lua_activity180_element", package.seeall)

local lua_activity180_element = {}
local fields = {
	episodeId = 4,
	name = 2,
	id = 1,
	sequence = 5,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity180_element.onLoad(json)
	lua_activity180_element.configList, lua_activity180_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity180_element
