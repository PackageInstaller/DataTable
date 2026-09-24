-- chunkname: @modules/configs/excel2json/lua_college_actor.lua

module("modules.configs.excel2json.lua_college_actor", package.seeall)

local lua_college_actor = {}
local fields = {
	name = 2,
	rarity = 4,
	avatar = 5,
	type = 3,
	id = 1,
	pieceAsset = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_college_actor.onLoad(json)
	lua_college_actor.configList, lua_college_actor.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_actor
