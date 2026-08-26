-- chunkname: @modules/configs/excel2json/lua_assassin_quest.lua

module("modules.configs.excel2json.lua_assassin_quest", package.seeall)

local lua_assassin_quest = {}
local fields = {
	param = 8,
	display = 10,
	unlock = 9,
	type = 7,
	picture = 4,
	title = 2,
	rewardCount = 11,
	desc = 3,
	mapId = 5,
	id = 1,
	position = 6,
	recommend = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_assassin_quest.onLoad(json)
	lua_assassin_quest.configList, lua_assassin_quest.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_quest
