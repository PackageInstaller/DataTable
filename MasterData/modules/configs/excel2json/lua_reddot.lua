-- chunkname: @modules/configs/excel2json/lua_reddot.lua

module("modules.configs.excel2json.lua_reddot", package.seeall)

local lua_reddot = {}
local fields = {
	canLoad = 4,
	isOnline = 3,
	parent = 2,
	style = 5,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_reddot.onLoad(json)
	lua_reddot.configList, lua_reddot.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_reddot
