-- chunkname: @modules/configs/excel2json/lua_dice_level.lua

module("modules.configs.excel2json.lua_dice_level", package.seeall)

local lua_dice_level = {}
local fields = {
	chapter = 3,
	enemyType = 6,
	isSkip = 10,
	type = 5,
	rewardSelectType = 8,
	mode = 7,
	room = 4,
	dialog = 9,
	id = 1,
	chapterName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	chapterName = 1
}

function lua_dice_level.onLoad(json)
	lua_dice_level.configList, lua_dice_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dice_level
