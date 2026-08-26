-- chunkname: @modules/configs/excel2json/lua_v3a5_text.lua

module("modules.configs.excel2json.lua_v3a5_text", package.seeall)

local lua_v3a5_text = {}
local fields = {
	text = 3,
	voiceId = 5,
	id = 1,
	characterId = 2,
	groupId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	text = 1
}

function lua_v3a5_text.onLoad(json)
	lua_v3a5_text.configList, lua_v3a5_text.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v3a5_text
