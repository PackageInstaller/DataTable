-- chunkname: @modules/configs/excel2json/lua_rouge_badge.lua

module("modules.configs.excel2json.lua_rouge_badge", package.seeall)

local lua_rouge_badge = {}
local fields = {
	score = 8,
	name = 3,
	triggerParam = 7,
	id = 2,
	season = 1,
	icon = 5,
	trigger = 6,
	desc = 4
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rouge_badge.onLoad(json)
	lua_rouge_badge.configList, lua_rouge_badge.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_badge
