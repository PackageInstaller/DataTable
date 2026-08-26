-- chunkname: @modules/configs/excel2json/lua_fairy_land_element.lua

module("modules.configs.excel2json.lua_fairy_land_element", package.seeall)

local lua_fairy_land_element = {}
local fields = {
	id = 1,
	puzzleId = 4,
	pos = 3,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fairy_land_element.onLoad(json)
	lua_fairy_land_element.configList, lua_fairy_land_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fairy_land_element
