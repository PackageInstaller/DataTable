-- chunkname: @modules/configs/excel2json/lua_rouge_extra_desc.lua

module("modules.configs.excel2json.lua_rouge_extra_desc", package.seeall)

local lua_rouge_extra_desc = {}
local fields = {
	id = 1,
	name = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rouge_extra_desc.onLoad(json)
	lua_rouge_extra_desc.configList, lua_rouge_extra_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_extra_desc
