-- chunkname: @modules/configs/excel2json/lua_musicgame_const.lua

module("modules.configs.excel2json.lua_musicgame_const", package.seeall)

local lua_musicgame_const = {}
local fields = {
	id = 1,
	strValue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_musicgame_const.onLoad(json)
	lua_musicgame_const.configList, lua_musicgame_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_musicgame_const
