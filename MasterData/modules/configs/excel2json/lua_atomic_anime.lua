-- chunkname: @modules/configs/excel2json/lua_atomic_anime.lua

module("modules.configs.excel2json.lua_atomic_anime", package.seeall)

local lua_atomic_anime = {}
local fields = {
	name = 3,
	res = 4,
	levelid = 2,
	video = 5,
	isloop = 6,
	place = 7,
	animeid = 1
}
local primaryKey = {
	"animeid"
}
local mlStringKey = {
	place = 2,
	name = 1
}

function lua_atomic_anime.onLoad(json)
	lua_atomic_anime.configList, lua_atomic_anime.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_anime
