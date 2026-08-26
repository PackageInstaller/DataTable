-- chunkname: @modules/configs/excel2json/lua_assassin_library.lua

module("modules.configs.excel2json.lua_assassin_library", package.seeall)

local lua_assassin_library = {}
local fields = {
	toastIcon = 7,
	storyId = 11,
	type = 5,
	title = 2,
	content = 3,
	unlock = 9,
	res = 6,
	talk = 10,
	id = 1,
	activityId = 4,
	detail = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	title = 1
}

function lua_assassin_library.onLoad(json)
	lua_assassin_library.configList, lua_assassin_library.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_library
