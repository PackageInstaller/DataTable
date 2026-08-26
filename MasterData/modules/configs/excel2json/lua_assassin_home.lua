-- chunkname: @modules/configs/excel2json/lua_assassin_home.lua

module("modules.configs.excel2json.lua_assassin_home", package.seeall)

local lua_assassin_home = {}
local fields = {
	unlock = 5,
	effect = 7,
	unlockDesc = 6,
	type = 3,
	id = 1,
	title = 2,
	effectDesc = 8,
	level = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	effectDesc = 2,
	title = 1
}

function lua_assassin_home.onLoad(json)
	lua_assassin_home.configList, lua_assassin_home.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_home
