-- chunkname: @modules/configs/excel2json/lua_meme.lua

module("modules.configs.excel2json.lua_meme", package.seeall)

local lua_meme = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_meme.onLoad(json)
	lua_meme.configList, lua_meme.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_meme
