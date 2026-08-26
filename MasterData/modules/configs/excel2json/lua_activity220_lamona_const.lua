-- chunkname: @modules/configs/excel2json/lua_activity220_lamona_const.lua

module("modules.configs.excel2json.lua_activity220_lamona_const", package.seeall)

local lua_activity220_lamona_const = {}
local fields = {
	value = 2,
	id = 1,
	mlvalue = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	mlvalue = 1
}

function lua_activity220_lamona_const.onLoad(json)
	lua_activity220_lamona_const.configList, lua_activity220_lamona_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_lamona_const
