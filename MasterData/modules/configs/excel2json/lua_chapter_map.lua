-- chunkname: @modules/configs/excel2json/lua_chapter_map.lua

module("modules.configs.excel2json.lua_chapter_map", package.seeall)

local lua_chapter_map = {}
local fields = {
	areaAudio = 8,
	mapIdGroup = 10,
	unlockCondition = 3,
	chapterId = 2,
	mapState = 9,
	initPos = 6,
	effectAudio = 7,
	desc = 5,
	res = 4,
	playEffect = 11,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_chapter_map.onLoad(json)
	lua_chapter_map.configList, lua_chapter_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_map
