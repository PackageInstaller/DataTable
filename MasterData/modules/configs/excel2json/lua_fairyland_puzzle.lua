-- chunkname: @modules/configs/excel2json/lua_fairyland_puzzle.lua

module("modules.configs.excel2json.lua_fairyland_puzzle", package.seeall)

local lua_fairyland_puzzle = {}
local fields = {
	id = 1,
	afterTalkId = 5,
	errorTalkId = 8,
	beforeTalkId = 4,
	storyTalkId = 9,
	elementId = 3,
	successTalkId = 6,
	tipsTalkId = 7,
	answer = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fairyland_puzzle.onLoad(json)
	lua_fairyland_puzzle.configList, lua_fairyland_puzzle.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fairyland_puzzle
