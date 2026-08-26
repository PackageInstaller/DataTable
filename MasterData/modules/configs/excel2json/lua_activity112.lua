-- chunkname: @modules/configs/excel2json/lua_activity112.lua

module("modules.configs.excel2json.lua_activity112", package.seeall)

local lua_activity112 = {}
local fields = {
	items = 3,
	theme2 = 12,
	themeDone2 = 14,
	theme = 11,
	themeDone = 13,
	skin = 6,
	skinOffSet = 7,
	chatheadsOffSet = 10,
	head = 5,
	storyId = 15,
	skin2OffSet = 9,
	skin2 = 8,
	id = 2,
	activityId = 1,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	themeDone = 3,
	themeDone2 = 4,
	theme2 = 2,
	theme = 1
}

function lua_activity112.onLoad(json)
	lua_activity112.configList, lua_activity112.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity112
