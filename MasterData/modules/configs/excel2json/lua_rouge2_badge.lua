-- chunkname: @modules/configs/excel2json/lua_rouge2_badge.lua

module("modules.configs.excel2json.lua_rouge2_badge", package.seeall)

local lua_rouge2_badge = {}
local fields = {
	score = 6,
	name = 2,
	id = 1,
	icon = 4,
	trigger = 5,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rouge2_badge.onLoad(json)
	lua_rouge2_badge.configList, lua_rouge2_badge.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_badge
