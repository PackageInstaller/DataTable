-- chunkname: @modules/configs/excel2json/lua_character_motion_special.lua

module("modules.configs.excel2json.lua_character_motion_special", package.seeall)

local lua_character_motion_special = {}
local fields = {
	heroResName = 1,
	skipStopMouth = 2
}
local primaryKey = {
	"heroResName"
}
local mlStringKey = {}

function lua_character_motion_special.onLoad(json)
	lua_character_motion_special.configList, lua_character_motion_special.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_motion_special
