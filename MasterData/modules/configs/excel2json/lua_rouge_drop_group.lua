-- chunkname: @modules/configs/excel2json/lua_rouge_drop_group.lua

module("modules.configs.excel2json.lua_rouge_drop_group", package.seeall)

local lua_rouge_drop_group = {}
local fields = {
	groupId = 2,
	id = 1,
	collectionId = 3,
	rate = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_drop_group.onLoad(json)
	lua_rouge_drop_group.configList, lua_rouge_drop_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_drop_group
