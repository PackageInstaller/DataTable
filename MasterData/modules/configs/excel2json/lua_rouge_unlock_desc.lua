-- chunkname: @modules/configs/excel2json/lua_rouge_unlock_desc.lua

module("modules.configs.excel2json.lua_rouge_unlock_desc", package.seeall)

local lua_rouge_unlock_desc = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge_unlock_desc.onLoad(json)
	lua_rouge_unlock_desc.configList, lua_rouge_unlock_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_unlock_desc
