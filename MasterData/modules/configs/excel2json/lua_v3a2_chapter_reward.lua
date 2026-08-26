-- chunkname: @modules/configs/excel2json/lua_v3a2_chapter_reward.lua

module("modules.configs.excel2json.lua_v3a2_chapter_reward", package.seeall)

local lua_v3a2_chapter_reward = {}
local fields = {
	id = 1,
	reward = 3,
	count = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_v3a2_chapter_reward.onLoad(json)
	lua_v3a2_chapter_reward.configList, lua_v3a2_chapter_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v3a2_chapter_reward
