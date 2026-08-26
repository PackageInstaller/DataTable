-- chunkname: @modules/configs/excel2json/lua_partygame_dodgebullets.lua

module("modules.configs.excel2json.lua_partygame_dodgebullets", package.seeall)

local lua_partygame_dodgebullets = {}
local fields = {
	delay = 2,
	num = 3,
	id = 1,
	interval = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_dodgebullets.onLoad(json)
	lua_partygame_dodgebullets.configList, lua_partygame_dodgebullets.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_dodgebullets
