-- chunkname: @modules/configs/excel2json/lua_rouge2_dice_check.lua

module("modules.configs.excel2json.lua_rouge2_dice_check", package.seeall)

local lua_rouge2_dice_check = {}
local fields = {
	dice = 6,
	attrType = 4,
	desc = 5,
	retryCost = 7,
	id = 1,
	checkPoint = 3,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {}

function lua_rouge2_dice_check.onLoad(json)
	lua_rouge2_dice_check.configList, lua_rouge2_dice_check.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_dice_check
