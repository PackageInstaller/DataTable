-- chunkname: @modules/configs/excel2json/lua_character_limited.lua

module("modules.configs.excel2json.lua_character_limited", package.seeall)

local lua_character_limited = {}
local fields = {
	spine = 2,
	mvtime = 5,
	spineParam = 3,
	entranceMv = 4,
	voice = 6,
	characterVoice = 14,
	stopAudio = 11,
	storeMv = 15,
	storeMvAudio = 16,
	entranceEffect = 8,
	specialLive2d = 13,
	audio = 10,
	actionTime = 7,
	specialInsightDesc = 12,
	effectDuration = 9,
	storeMvStopAudio = 17,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	specialInsightDesc = 1
}

function lua_character_limited.onLoad(json)
	lua_character_limited.configList, lua_character_limited.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_limited
