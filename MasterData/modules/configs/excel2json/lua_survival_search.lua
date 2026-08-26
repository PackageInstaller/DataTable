-- chunkname: @modules/configs/excel2json/lua_survival_search.lua

module("modules.configs.excel2json.lua_survival_search", package.seeall)

local lua_survival_search = {}
local fields = {
	drop = 15,
	name = 2,
	desc = 6,
	rotate = 11,
	grid = 10,
	choiceText = 13,
	copyIds = 18,
	camera = 12,
	worldLevel = 19,
	subType = 17,
	isRepeat = 20,
	consume = 14,
	incidental = 22,
	exp = 24,
	versions = 4,
	priority = 7,
	incidentalRange = 23,
	group = 3,
	roll = 21,
	resource = 8,
	enforce = 16,
	seasons = 5,
	id = 1,
	waterResource = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	choiceText = 3,
	name = 1,
	desc = 2
}

function lua_survival_search.onLoad(json)
	lua_survival_search.configList, lua_survival_search.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_search
