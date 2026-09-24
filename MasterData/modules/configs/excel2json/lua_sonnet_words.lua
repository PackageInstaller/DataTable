-- chunkname: @modules/configs/excel2json/lua_sonnet_words.lua

module("modules.configs.excel2json.lua_sonnet_words", package.seeall)

local lua_sonnet_words = {}
local fields = {
	elementId = 2,
	noteCoordinates = 6,
	coordinates = 5,
	id = 1,
	dialogId = 4,
	words = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	words = 1
}

function lua_sonnet_words.onLoad(json)
	lua_sonnet_words.configList, lua_sonnet_words.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sonnet_words
