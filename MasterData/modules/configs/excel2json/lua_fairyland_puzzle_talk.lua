-- chunkname: @modules/configs/excel2json/lua_fairyland_puzzle_talk.lua

module("modules.configs.excel2json.lua_fairyland_puzzle_talk", package.seeall)

local lua_fairyland_puzzle_talk = {}
local fields = {
	param = 4,
	audioId = 5,
	speaker = 6,
	type = 3,
	id = 1,
	elementId = 8,
	content = 7,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {
	speaker = 1,
	content = 2
}

function lua_fairyland_puzzle_talk.onLoad(json)
	lua_fairyland_puzzle_talk.configList, lua_fairyland_puzzle_talk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fairyland_puzzle_talk
