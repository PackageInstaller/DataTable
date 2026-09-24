-- chunkname: @modules/configs/excel2json/lua_sonnet_ink.lua

module("modules.configs.excel2json.lua_sonnet_ink", package.seeall)

local lua_sonnet_ink = {}
local fields = {
	id = 1,
	wordsGroup = 2,
	poemId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_sonnet_ink.onLoad(json)
	lua_sonnet_ink.configList, lua_sonnet_ink.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sonnet_ink
