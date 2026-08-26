-- chunkname: @modules/configs/excel2json/lua_explore_chest.lua

module("modules.configs.excel2json.lua_explore_chest", package.seeall)

local lua_explore_chest = {}
local fields = {
	bonus = 4,
	isCount = 5,
	chapterId = 3,
	id = 1,
	episodeId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_explore_chest.onLoad(json)
	lua_explore_chest.configList, lua_explore_chest.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_explore_chest
