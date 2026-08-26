-- chunkname: @modules/configs/excel2json/lua_udimo_background.lua

module("modules.configs.excel2json.lua_udimo_background", package.seeall)

local lua_udimo_background = {}
local fields = {
	id = 1,
	name = 2,
	airPoints = 7,
	defaultUse = 5,
	defaultWeather = 10,
	bgm = 9,
	cameraMoveRange = 8,
	img = 3,
	isDefault = 4,
	sceneLevel = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_udimo_background.onLoad(json)
	lua_udimo_background.configList, lua_udimo_background.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo_background
