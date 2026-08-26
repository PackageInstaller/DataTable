-- chunkname: @modules/configs/excel2json/lua_rouge_limit_unlock.lua

module("modules.configs.excel2json.lua_rouge_limit_unlock", package.seeall)

local lua_rouge_limit_unlock = {}
local fields = {
	style = 4,
	unlockCost = 5,
	skillId = 3,
	id = 1,
	version = 2
}
local primaryKey = {
	"id",
	"version"
}
local mlStringKey = {}

function lua_rouge_limit_unlock.onLoad(json)
	lua_rouge_limit_unlock.configList, lua_rouge_limit_unlock.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_limit_unlock
