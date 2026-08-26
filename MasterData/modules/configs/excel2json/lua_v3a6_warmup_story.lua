-- chunkname: @modules/configs/excel2json/lua_v3a6_warmup_story.lua

module("modules.configs.excel2json.lua_v3a6_warmup_story", package.seeall)

local lua_v3a6_warmup_story = {}
local fields = {
	group = 2,
	cutscene = 4,
	id = 1,
	bg = 5,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_v3a6_warmup_story.onLoad(json)
	lua_v3a6_warmup_story.configList, lua_v3a6_warmup_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v3a6_warmup_story
