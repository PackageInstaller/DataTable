-- chunkname: @modules/configs/excel2json/lua_rouge_genius_branch.lua

module("modules.configs.excel2json.lua_rouge_genius_branch", package.seeall)

local lua_rouge_genius_branch = {}
local fields = {
	cost = 11,
	openDesc = 8,
	isOrigin = 14,
	startView = 13,
	season = 1,
	show = 12,
	pos = 6,
	desc = 15,
	effects = 9,
	talent = 3,
	initialCollection = 10,
	name = 4,
	id = 2,
	icon = 16,
	before = 5,
	attribute = 7
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rouge_genius_branch.onLoad(json)
	lua_rouge_genius_branch.configList, lua_rouge_genius_branch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_genius_branch
