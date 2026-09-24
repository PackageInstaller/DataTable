-- chunkname: @modules/configs/excel2json/lua_sonnet_poem.lua

module("modules.configs.excel2json.lua_sonnet_poem", package.seeall)

local lua_sonnet_poem = {}
local fields = {
	poem = 2,
	id = 1,
	audioId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	poem = 1
}

function lua_sonnet_poem.onLoad(json)
	lua_sonnet_poem.configList, lua_sonnet_poem.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sonnet_poem
