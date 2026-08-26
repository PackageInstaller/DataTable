-- chunkname: @modules/configs/excel2json/lua_rouge_drop.lua

module("modules.configs.excel2json.lua_rouge_drop", package.seeall)

local lua_rouge_drop = {}
local fields = {
	power = 4,
	enterBag = 9,
	notOwned = 10,
	exp = 5,
	drop = 8,
	talent = 3,
	selectCount = 6,
	coin = 2,
	id = 1,
	dropCount = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_drop.onLoad(json)
	lua_rouge_drop.configList, lua_rouge_drop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_drop
