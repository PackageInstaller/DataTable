-- chunkname: @modules/configs/excel2json/lua_instruction_level.lua

module("modules.configs.excel2json.lua_instruction_level", package.seeall)

local lua_instruction_level = {}
local fields = {
	picRes = 7,
	desc = 6,
	topicId = 2,
	instructionDesc = 4,
	id = 1,
	desc_en = 5,
	preEpisode = 8,
	episodeId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	instructionDesc = 1
}

function lua_instruction_level.onLoad(json)
	lua_instruction_level.configList, lua_instruction_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_instruction_level
