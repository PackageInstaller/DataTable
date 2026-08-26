-- chunkname: @modules/configs/excel2json/lua_dice.lua

module("modules.configs.excel2json.lua_dice", package.seeall)

local lua_dice = {}
local fields = {
	id = 1,
	suitList = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_dice.onLoad(json)
	lua_dice.configList, lua_dice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dice
