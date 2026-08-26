-- chunkname: @modules/configs/excel2json/lua_udimo_background_area.lua

module("modules.configs.excel2json.lua_udimo_background_area", package.seeall)

local lua_udimo_background_area = {}
local fields = {
	groupId = 2,
	xMoveRange = 5,
	id = 1,
	yLevel = 4,
	zLevel = 3
}
local primaryKey = {
	"id",
	"groupId"
}
local mlStringKey = {}

function lua_udimo_background_area.onLoad(json)
	lua_udimo_background_area.configList, lua_udimo_background_area.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo_background_area
