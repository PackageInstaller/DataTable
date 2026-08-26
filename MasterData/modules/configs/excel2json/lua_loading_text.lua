-- chunkname: @modules/configs/excel2json/lua_loading_text.lua

module("modules.configs.excel2json.lua_loading_text", package.seeall)

local lua_loading_text = {}
local fields = {
	unlocklevel = 2,
	isOnline = 8,
	content = 6,
	titleen = 5,
	id = 1,
	title = 4,
	weight = 3,
	scenes = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	title = 1
}

function lua_loading_text.onLoad(json)
	lua_loading_text.configList, lua_loading_text.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_loading_text
