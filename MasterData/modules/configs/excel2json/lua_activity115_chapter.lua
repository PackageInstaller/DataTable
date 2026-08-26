-- chunkname: @modules/configs/excel2json/lua_activity115_chapter.lua

module("modules.configs.excel2json.lua_activity115_chapter", package.seeall)

local lua_activity115_chapter = {}
local fields = {
	id = 2,
	name = 3,
	ambientAudio = 6,
	name_En = 4,
	activityId = 1,
	openId = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity115_chapter.onLoad(json)
	lua_activity115_chapter.configList, lua_activity115_chapter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity115_chapter
