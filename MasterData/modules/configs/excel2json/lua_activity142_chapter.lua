-- chunkname: @modules/configs/excel2json/lua_activity142_chapter.lua

module("modules.configs.excel2json.lua_activity142_chapter", package.seeall)

local lua_activity142_chapter = {}
local fields = {
	selectSprite = 6,
	name = 3,
	lockSprite = 7,
	txtColor = 4,
	id = 2,
	normalSprite = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity142_chapter.onLoad(json)
	lua_activity142_chapter.configList, lua_activity142_chapter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity142_chapter
