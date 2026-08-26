-- chunkname: @modules/configs/excel2json/lua_rouge_limit_group.lua

module("modules.configs.excel2json.lua_rouge_limit_group", package.seeall)

local lua_rouge_limit_group = {}
local fields = {
	version = 2,
	unlockCondition = 5,
	icon = 6,
	id = 1,
	title = 3,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_rouge_limit_group.onLoad(json)
	lua_rouge_limit_group.configList, lua_rouge_limit_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_limit_group
