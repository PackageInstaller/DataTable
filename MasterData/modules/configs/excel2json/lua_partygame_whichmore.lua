-- chunkname: @modules/configs/excel2json/lua_partygame_whichmore.lua

module("modules.configs.excel2json.lua_partygame_whichmore", package.seeall)

local lua_partygame_whichmore = {}
local fields = {
	othersFlip = 5,
	picture = 2,
	pictureNumber = 3,
	id = 1,
	firstFlip = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_whichmore.onLoad(json)
	lua_partygame_whichmore.configList, lua_partygame_whichmore.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_whichmore
