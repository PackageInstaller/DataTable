-- chunkname: @modules/configs/excel2json/lua_helppage.lua

module("modules.configs.excel2json.lua_helppage", package.seeall)

local lua_helppage = {}
local fields = {
	text = 4,
	icon = 5,
	unlockGuideId = 7,
	type = 3,
	id = 1,
	title = 2,
	isCn = 8,
	iconText = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}

function lua_helppage.onLoad(json)
	lua_helppage.configList, lua_helppage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_helppage
