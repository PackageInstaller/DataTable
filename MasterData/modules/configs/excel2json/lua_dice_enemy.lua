-- chunkname: @modules/configs/excel2json/lua_dice_enemy.lua

module("modules.configs.excel2json.lua_dice_enemy", package.seeall)

local lua_dice_enemy = {}
local fields = {
	id = 1,
	icon = 2,
	hp = 4,
	bufflist = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_dice_enemy.onLoad(json)
	lua_dice_enemy.configList, lua_dice_enemy.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dice_enemy
