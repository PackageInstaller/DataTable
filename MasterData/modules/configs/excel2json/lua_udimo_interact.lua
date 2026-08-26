-- chunkname: @modules/configs/excel2json/lua_udimo_interact.lua

module("modules.configs.excel2json.lua_udimo_interact", package.seeall)

local lua_udimo_interact = {}
local fields = {
	isLeft = 4,
	emoji = 5,
	orderLayer = 6,
	belongBG = 1,
	groupIds = 3,
	interactId = 2
}
local primaryKey = {
	"belongBG",
	"interactId"
}
local mlStringKey = {}

function lua_udimo_interact.onLoad(json)
	lua_udimo_interact.configList, lua_udimo_interact.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo_interact
