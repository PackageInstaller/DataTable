-- chunkname: @modules/configs/excel2json/lua_rouge_unlock_skills.lua

module("modules.configs.excel2json.lua_rouge_unlock_skills", package.seeall)

local lua_rouge_unlock_skills = {}
local fields = {
	unlockEmblem = 5,
	style = 2,
	type = 4,
	skillId = 1,
	version = 3
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}

function lua_rouge_unlock_skills.onLoad(json)
	lua_rouge_unlock_skills.configList, lua_rouge_unlock_skills.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_unlock_skills
