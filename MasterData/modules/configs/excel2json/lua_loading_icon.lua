-- chunkname: @modules/configs/excel2json/lua_loading_icon.lua

module("modules.configs.excel2json.lua_loading_icon", package.seeall)

local lua_loading_icon = {}
local fields = {
	weight = 4,
	isOnline = 6,
	type = 5,
	id = 1,
	pic = 2,
	scenes = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_loading_icon.onLoad(json)
	lua_loading_icon.configList, lua_loading_icon.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_loading_icon
