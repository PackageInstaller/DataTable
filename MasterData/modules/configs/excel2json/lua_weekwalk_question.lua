-- chunkname: @modules/configs/excel2json/lua_weekwalk_question.lua

module("modules.configs.excel2json.lua_weekwalk_question", package.seeall)

local lua_weekwalk_question = {}
local fields = {
	text = 2,
	select3 = 5,
	select2 = 4,
	id = 1,
	select1 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	text = 1,
	select1 = 2,
	select3 = 4,
	select2 = 3
}

function lua_weekwalk_question.onLoad(json)
	lua_weekwalk_question.configList, lua_weekwalk_question.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_question
