-- chunkname: @modules/configs/excel2json/lua_activity184_puzzle_episode.lua

module("modules.configs.excel2json.lua_activity184_puzzle_episode", package.seeall)

local lua_activity184_puzzle_episode = {}
local fields = {
	titile = 10,
	titleTxt = 7,
	date = 6,
	txt = 9,
	target = 5,
	illustrationCount = 8,
	staticShape = 4,
	id = 2,
	size = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	txt = 2,
	titleTxt = 1,
	titile = 3
}

function lua_activity184_puzzle_episode.onLoad(json)
	lua_activity184_puzzle_episode.configList, lua_activity184_puzzle_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity184_puzzle_episode
