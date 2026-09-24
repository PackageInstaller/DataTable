-- chunkname: @modules/configs/excel2json/lua_musicgame_level.lua

module("modules.configs.excel2json.lua_musicgame_level", package.seeall)

local lua_musicgame_level = {}
local fields = {
	score = 2,
	strValue = 3,
	audioId = 4,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {
	strValue = 1
}

function lua_musicgame_level.onLoad(json)
	lua_musicgame_level.configList, lua_musicgame_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_musicgame_level
