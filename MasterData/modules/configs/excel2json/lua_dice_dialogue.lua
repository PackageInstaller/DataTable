-- chunkname: @modules/configs/excel2json/lua_dice_dialogue.lua

module("modules.configs.excel2json.lua_dice_dialogue", package.seeall)

local lua_dice_dialogue = {}
local fields = {
	speaker = 3,
	desc = 4,
	line = 5,
	type = 6,
	id = 1,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {
	speaker = 1,
	desc = 2
}

function lua_dice_dialogue.onLoad(json)
	lua_dice_dialogue.configList, lua_dice_dialogue.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dice_dialogue
