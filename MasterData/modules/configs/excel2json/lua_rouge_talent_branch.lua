-- chunkname: @modules/configs/excel2json/lua_rouge_talent_branch.lua

module("modules.configs.excel2json.lua_rouge_talent_branch", package.seeall)

local lua_rouge_talent_branch = {}
local fields = {
	cost = 8,
	name = 3,
	isOrigin = 9,
	before = 4,
	pos = 5,
	desc = 10,
	talent = 2,
	special = 7,
	id = 1,
	icon = 11,
	attribute = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rouge_talent_branch.onLoad(json)
	lua_rouge_talent_branch.configList, lua_rouge_talent_branch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_talent_branch
