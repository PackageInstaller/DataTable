-- chunkname: @modules/configs/excel2json/lua_activity166_word_effect_pos.lua

module("modules.configs.excel2json.lua_activity166_word_effect_pos", package.seeall)

local lua_activity166_word_effect_pos = {}
local fields = {
	id = 2,
	pos = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity166_word_effect_pos.onLoad(json)
	lua_activity166_word_effect_pos.configList, lua_activity166_word_effect_pos.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_word_effect_pos
