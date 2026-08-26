-- chunkname: @modules/configs/excel2json/lua_rouge2_short_voice.lua

module("modules.configs.excel2json.lua_rouge2_short_voice", package.seeall)

local lua_rouge2_short_voice = {}
local fields = {
	audioId = 2,
	id = 1,
	groupId = 3,
	weight = 5,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge2_short_voice.onLoad(json)
	lua_rouge2_short_voice.configList, lua_rouge2_short_voice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_short_voice
