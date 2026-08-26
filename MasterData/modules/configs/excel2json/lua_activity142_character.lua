-- chunkname: @modules/configs/excel2json/lua_activity142_character.lua

module("modules.configs.excel2json.lua_activity142_character", package.seeall)

local lua_activity142_character = {}
local fields = {
	activityId = 1,
	canTriggerPedal = 3,
	canUseFireball = 5,
	canBreakTile = 6,
	characterType = 2,
	canLightBrazier = 4
}
local primaryKey = {
	"activityId",
	"characterType"
}
local mlStringKey = {}

function lua_activity142_character.onLoad(json)
	lua_activity142_character.configList, lua_activity142_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity142_character
