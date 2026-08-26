-- chunkname: @modules/configs/excel2json/lua_partygame_whichmore_pictures.lua

module("modules.configs.excel2json.lua_partygame_whichmore_pictures", package.seeall)

local lua_partygame_whichmore_pictures = {}
local fields = {
	id = 1,
	resource = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_whichmore_pictures.onLoad(json)
	lua_partygame_whichmore_pictures.configList, lua_partygame_whichmore_pictures.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_whichmore_pictures
