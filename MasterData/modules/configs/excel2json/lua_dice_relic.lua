-- chunkname: @modules/configs/excel2json/lua_dice_relic.lua

module("modules.configs.excel2json.lua_dice_relic", package.seeall)

local lua_dice_relic = {}
local fields = {
	param = 6,
	name = 2,
	effect = 5,
	id = 1,
	icon = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_dice_relic.onLoad(json)
	lua_dice_relic.configList, lua_dice_relic.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dice_relic
