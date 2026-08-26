-- chunkname: @modules/configs/excel2json/lua_login_view_page.lua

module("modules.configs.excel2json.lua_login_view_page", package.seeall)

local lua_login_view_page = {}
local fields = {
	audioId = 6,
	prefab = 3,
	id = 1,
	stopAudioId = 7,
	bgimage = 4,
	name = 2,
	video = 5,
	episodeId = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_login_view_page.onLoad(json)
	lua_login_view_page.configList, lua_login_view_page.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_login_view_page
