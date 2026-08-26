-- chunkname: @modules/configs/excel2json/lua_sodache_dice_face.lua

module("modules.configs.excel2json.lua_sodache_dice_face", package.seeall)

local lua_sodache_dice_face = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_sodache_dice_face.onLoad(json)
	lua_sodache_dice_face.configList, lua_sodache_dice_face.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_dice_face
