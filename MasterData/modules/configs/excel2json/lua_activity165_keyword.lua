-- chunkname: @modules/configs/excel2json/lua_activity165_keyword.lua

module("modules.configs.excel2json.lua_activity165_keyword", package.seeall)

local lua_activity165_keyword = {}
local fields = {
	keywordId = 1,
	text = 3,
	pic = 4,
	belongStoryId = 2
}
local primaryKey = {
	"keywordId"
}
local mlStringKey = {
	text = 1
}

function lua_activity165_keyword.onLoad(json)
	lua_activity165_keyword.configList, lua_activity165_keyword.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity165_keyword
