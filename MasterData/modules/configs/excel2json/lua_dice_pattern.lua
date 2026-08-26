-- chunkname: @modules/configs/excel2json/lua_dice_pattern.lua

module("modules.configs.excel2json.lua_dice_pattern", package.seeall)

local lua_dice_pattern = {}
local fields = {
	id = 1,
	patternList = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_dice_pattern.onLoad(json)
	lua_dice_pattern.configList, lua_dice_pattern.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dice_pattern
