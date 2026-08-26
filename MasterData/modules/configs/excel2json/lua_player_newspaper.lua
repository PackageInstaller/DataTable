-- chunkname: @modules/configs/excel2json/lua_player_newspaper.lua

module("modules.configs.excel2json.lua_player_newspaper", package.seeall)

local lua_player_newspaper = {}
local fields = {
	name = 3,
	type = 2,
	id = 1,
	displayPriority = 5,
	nameEn = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_player_newspaper.onLoad(json)
	lua_player_newspaper.configList, lua_player_newspaper.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_player_newspaper
