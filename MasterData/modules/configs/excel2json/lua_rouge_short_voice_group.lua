-- chunkname: @modules/configs/excel2json/lua_rouge_short_voice_group.lua

module("modules.configs.excel2json.lua_rouge_short_voice_group", package.seeall)

local lua_rouge_short_voice_group = {}
local fields = {
	triggerType = 2,
	id = 1,
	triggerParam = 3,
	rate = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_short_voice_group.onLoad(json)
	lua_rouge_short_voice_group.configList, lua_rouge_short_voice_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_short_voice_group
