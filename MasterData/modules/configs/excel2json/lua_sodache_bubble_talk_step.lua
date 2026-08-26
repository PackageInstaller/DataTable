-- chunkname: @modules/configs/excel2json/lua_sodache_bubble_talk_step.lua

module("modules.configs.excel2json.lua_sodache_bubble_talk_step", package.seeall)

local lua_sodache_bubble_talk_step = {}
local fields = {
	id = 1,
	content = 3,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {
	content = 1
}

function lua_sodache_bubble_talk_step.onLoad(json)
	lua_sodache_bubble_talk_step.configList, lua_sodache_bubble_talk_step.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_bubble_talk_step
