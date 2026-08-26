-- chunkname: @modules/configs/excel2json/lua_rouge2_dice.lua

module("modules.configs.excel2json.lua_rouge2_dice", package.seeall)

local lua_rouge2_dice = {}
local fields = {
	sides = 2,
	id = 1,
	point = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_dice.onLoad(json)
	lua_rouge2_dice.configList, lua_rouge2_dice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_dice
