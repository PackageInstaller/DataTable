-- chunkname: @modules/configs/excel2json/lua_dice_point.lua

module("modules.configs.excel2json.lua_dice_point", package.seeall)

local lua_dice_point = {}
local fields = {
	id = 1,
	pointList = 2,
	txt = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_dice_point.onLoad(json)
	lua_dice_point.configList, lua_dice_point.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dice_point
