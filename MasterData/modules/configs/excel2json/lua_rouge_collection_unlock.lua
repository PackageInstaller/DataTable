-- chunkname: @modules/configs/excel2json/lua_rouge_collection_unlock.lua

module("modules.configs.excel2json.lua_rouge_collection_unlock", package.seeall)

local lua_rouge_collection_unlock = {}
local fields = {
	typeSort = 3,
	unlockType = 5,
	sortId = 2,
	rareSort = 4,
	id = 1,
	unlockParam = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_collection_unlock.onLoad(json)
	lua_rouge_collection_unlock.configList, lua_rouge_collection_unlock.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_collection_unlock
