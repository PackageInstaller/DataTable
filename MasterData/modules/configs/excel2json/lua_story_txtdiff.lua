-- chunkname: @modules/configs/excel2json/lua_story_txtdiff.lua

module("modules.configs.excel2json.lua_story_txtdiff", package.seeall)

local lua_story_txtdiff = {}
local fields = {
	kr = 6,
	de = 8,
	cn = 3,
	tw = 4,
	thai = 10,
	fr = 9,
	en = 5,
	jp = 7,
	id = 1,
	lanType = 2
}
local primaryKey = {
	"id",
	"lanType"
}
local mlStringKey = {}

function lua_story_txtdiff.onLoad(json)
	lua_story_txtdiff.configList, lua_story_txtdiff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_txtdiff
