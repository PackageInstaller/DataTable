-- chunkname: @modules/configs/excel2json/lua_explore_bubble.lua

module("modules.configs.excel2json.lua_explore_bubble", package.seeall)

local lua_explore_bubble = {}
local fields = {
	id = 1,
	content = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}

function lua_explore_bubble.onLoad(json)
	lua_explore_bubble.configList, lua_explore_bubble.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_explore_bubble
