-- chunkname: @modules/configs/excel2json/lua_explore_dialogue.lua

module("modules.configs.excel2json.lua_explore_dialogue", package.seeall)

local lua_explore_dialogue = {}
local fields = {
	refuseButton = 8,
	bonusButton = 9,
	selectButton = 10,
	audio = 5,
	picture = 11,
	interrupt = 3,
	desc = 6,
	speaker = 4,
	id = 1,
	acceptButton = 7,
	stepid = 2
}
local primaryKey = {
	"id",
	"stepid"
}
local mlStringKey = {
	refuseButton = 4,
	speaker = 1,
	bonusButton = 5,
	selectButton = 6,
	acceptButton = 3,
	desc = 2
}

function lua_explore_dialogue.onLoad(json)
	lua_explore_dialogue.configList, lua_explore_dialogue.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_explore_dialogue
