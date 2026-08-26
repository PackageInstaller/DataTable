-- chunkname: @modules/configs/excel2json/lua_story_pictxt.lua

module("modules.configs.excel2json.lua_story_pictxt", package.seeall)

local lua_story_pictxt = {}
local fields = {
	kr = 6,
	de = 8,
	zh = 3,
	tw = 4,
	fontType = 2,
	fr = 9,
	en = 5,
	jp = 7,
	id = 1,
	thai = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_story_pictxt.onLoad(json)
	lua_story_pictxt.configList, lua_story_pictxt.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_pictxt
