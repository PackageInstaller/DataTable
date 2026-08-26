-- chunkname: @modules/configs/excel2json/lua_dice_suit.lua

module("modules.configs.excel2json.lua_dice_suit", package.seeall)

local lua_dice_suit = {}
local fields = {
	id = 1,
	icon = 3,
	suit = 2,
	icon2 = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_dice_suit.onLoad(json)
	lua_dice_suit.configList, lua_dice_suit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dice_suit
