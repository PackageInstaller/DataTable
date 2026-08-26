-- chunkname: @modules/configs/excel2json/lua_explore_scene.lua

module("modules.configs.excel2json.lua_explore_scene", package.seeall)

local lua_explore_scene = {}
local fields = {
	sceneId = 4,
	signsId = 5,
	chapterId = 1,
	id = 3,
	episodeId = 2
}
local primaryKey = {
	"chapterId",
	"episodeId"
}
local mlStringKey = {}

function lua_explore_scene.onLoad(json)
	lua_explore_scene.configList, lua_explore_scene.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_explore_scene
