-- chunkname: @modules/configs/excel2json/lua_copost_plot_map.lua

module("modules.configs.excel2json.lua_copost_plot_map", package.seeall)

local lua_copost_plot_map = {}
local fields = {
	id = 1,
	mapName = 5,
	time = 2,
	centerPoint = 3,
	scale = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	mapName = 1
}

function lua_copost_plot_map.onLoad(json)
	lua_copost_plot_map.configList, lua_copost_plot_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_plot_map
