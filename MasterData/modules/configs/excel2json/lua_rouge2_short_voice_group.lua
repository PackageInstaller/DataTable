-- chunkname: @modules/configs/excel2json/lua_rouge2_short_voice_group.lua

module("modules.configs.excel2json.lua_rouge2_short_voice_group", package.seeall)

local lua_rouge2_short_voice_group = {}
local fields = {
	id = 1,
	rate = 3,
	trigger = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_short_voice_group.onLoad(json)
	lua_rouge2_short_voice_group.configList, lua_rouge2_short_voice_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_short_voice_group
