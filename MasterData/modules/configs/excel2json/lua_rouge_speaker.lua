-- chunkname: @modules/configs/excel2json/lua_rouge_speaker.lua

module("modules.configs.excel2json.lua_rouge_speaker", package.seeall)

local lua_rouge_speaker = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3,
	nameIcon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	icon = 2,
	name = 1,
	nameIcon = 3
}

function lua_rouge_speaker.onLoad(json)
	lua_rouge_speaker.configList, lua_rouge_speaker.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_speaker
