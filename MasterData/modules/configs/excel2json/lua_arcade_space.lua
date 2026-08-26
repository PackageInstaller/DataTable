-- chunkname: @modules/configs/excel2json/lua_arcade_space.lua

module("modules.configs.excel2json.lua_arcade_space", package.seeall)

local lua_arcade_space = {}
local fields = {
	nodePortal6 = 9,
	firstRoom = 3,
	nodePortal1 = 4,
	nodePortal8 = 11,
	nodePortal2 = 5,
	nodePortal3 = 6,
	nodePortal4 = 7,
	nodePortal5 = 8,
	id = 1,
	node = 2,
	nodePortal7 = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_space.onLoad(json)
	lua_arcade_space.configList, lua_arcade_space.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_space
