-- chunkname: @modules/configs/excel2json/lua_rouge2_tag.lua

module("modules.configs.excel2json.lua_rouge2_tag", package.seeall)

local lua_rouge2_tag = {}
local fields = {
	id = 1,
	name = 2,
	iconUrl = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rouge2_tag.onLoad(json)
	lua_rouge2_tag.configList, lua_rouge2_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_tag
