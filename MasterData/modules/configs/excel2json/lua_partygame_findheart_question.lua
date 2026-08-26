-- chunkname: @modules/configs/excel2json/lua_partygame_findheart_question.lua

module("modules.configs.excel2json.lua_partygame_findheart_question", package.seeall)

local lua_partygame_findheart_question = {}
local fields = {
	id = 1,
	question = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	question = 1
}

function lua_partygame_findheart_question.onLoad(json)
	lua_partygame_findheart_question.configList, lua_partygame_findheart_question.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_findheart_question
