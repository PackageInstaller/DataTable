-- chunkname: @modules/configs/excel2json/lua_chapter_point_reward.lua

module("modules.configs.excel2json.lua_chapter_point_reward", package.seeall)

local lua_chapter_point_reward = {}
local fields = {
	reward = 4,
	display = 6,
	unlockChapter = 5,
	chapterId = 2,
	id = 1,
	rewardPointNum = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_chapter_point_reward.onLoad(json)
	lua_chapter_point_reward.configList, lua_chapter_point_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_chapter_point_reward
