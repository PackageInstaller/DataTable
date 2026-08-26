-- chunkname: @modules/configs/excel2json/lua_rouge_talk.lua

module("modules.configs.excel2json.lua_rouge_talk", package.seeall)

local lua_rouge_talk = {}
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

function lua_rouge_talk.onLoad(json)
	lua_rouge_talk.configList, lua_rouge_talk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_talk
