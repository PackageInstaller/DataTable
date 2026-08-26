-- chunkname: @modules/configs/excel2json/lua_activity166_word_effect.lua

module("modules.configs.excel2json.lua_activity166_word_effect", package.seeall)

local lua_activity166_word_effect = {}
local fields = {
	id = 2,
	type = 4,
	activityId = 1,
	desc = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity166_word_effect.onLoad(json)
	lua_activity166_word_effect.configList, lua_activity166_word_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_word_effect
