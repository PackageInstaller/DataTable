-- chunkname: @modules/configs/excel2json/lua_main_banner.lua

module("modules.configs.excel2json.lua_main_banner", package.seeall)

local lua_main_banner = {}
local fields = {
	sortId = 4,
	name = 2,
	jumpId = 5,
	appearanceRole = 7,
	id = 1,
	icon = 3,
	startEnd = 6,
	vanishingRule = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_main_banner.onLoad(json)
	lua_main_banner.configList, lua_main_banner.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_main_banner
