-- chunkname: @modules/configs/excel2json/lua_assassin_random.lua

module("modules.configs.excel2json.lua_assassin_random", package.seeall)

local lua_assassin_random = {}
local fields = {
	param = 4,
	name = 5,
	img = 6,
	type = 3,
	id = 1,
	weight = 2,
	desc = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_assassin_random.onLoad(json)
	lua_assassin_random.configList, lua_assassin_random.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_random
