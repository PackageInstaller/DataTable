-- chunkname: @modules/configs/excel2json/lua_critter_interaction_audio.lua

module("modules.configs.excel2json.lua_critter_interaction_audio", package.seeall)

local lua_critter_interaction_audio = {}
local fields = {
	animName = 2,
	critterId = 1,
	audioId = 3
}
local primaryKey = {
	"critterId",
	"animName"
}
local mlStringKey = {}

function lua_critter_interaction_audio.onLoad(json)
	lua_critter_interaction_audio.configList, lua_critter_interaction_audio.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_interaction_audio
