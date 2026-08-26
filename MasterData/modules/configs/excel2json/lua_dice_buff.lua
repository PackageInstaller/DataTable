-- chunkname: @modules/configs/excel2json/lua_dice_buff.lua

module("modules.configs.excel2json.lua_dice_buff", package.seeall)

local lua_dice_buff = {}
local fields = {
	triggerPoint = 8,
	effect = 7,
	name = 2,
	tag = 3,
	param = 9,
	damp = 10,
	roundLimitCount = 11,
	desc = 4,
	visible = 6,
	id = 1,
	icon = 5,
	allRoundLimitCount = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_dice_buff.onLoad(json)
	lua_dice_buff.configList, lua_dice_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dice_buff
