-- chunkname: @modules/configs/excel2json/lua_help_video.lua

module("modules.configs.excel2json.lua_help_video", package.seeall)

local lua_help_video = {}
local fields = {
	text = 4,
	videopath = 2,
	storyId = 6,
	type = 3,
	id = 1,
	icon = 5,
	unlockGuideId = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_help_video.onLoad(json)
	lua_help_video.configList, lua_help_video.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_help_video
