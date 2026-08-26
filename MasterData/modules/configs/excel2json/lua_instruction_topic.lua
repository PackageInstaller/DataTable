-- chunkname: @modules/configs/excel2json/lua_instruction_topic.lua

module("modules.configs.excel2json.lua_instruction_topic", package.seeall)

local lua_instruction_topic = {}
local fields = {
	id = 1,
	bonus = 3,
	chapterId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_instruction_topic.onLoad(json)
	lua_instruction_topic.configList, lua_instruction_topic.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_instruction_topic
