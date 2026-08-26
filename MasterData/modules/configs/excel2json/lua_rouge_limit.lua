-- chunkname: @modules/configs/excel2json/lua_rouge_limit.lua

module("modules.configs.excel2json.lua_rouge_limit", package.seeall)

local lua_rouge_limit = {}
local fields = {
	group = 3,
	startView = 8,
	riskValue = 7,
	title = 5,
	desc = 6,
	initCollections = 9,
	id = 1,
	version = 2,
	level = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_rouge_limit.onLoad(json)
	lua_rouge_limit.configList, lua_rouge_limit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_limit
