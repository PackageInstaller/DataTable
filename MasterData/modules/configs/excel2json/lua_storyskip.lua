-- chunkname: @modules/configs/excel2json/lua_storyskip.lua

module("modules.configs.excel2json.lua_storyskip", package.seeall)

local lua_storyskip = {}
local fields = {
	id = 1,
	skipDetail = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_storyskip.onLoad(json)
	lua_storyskip.configList, lua_storyskip.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_storyskip
