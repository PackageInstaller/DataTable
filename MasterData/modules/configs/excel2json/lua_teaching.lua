-- chunkname: @modules/configs/excel2json/lua_teaching.lua

module("modules.configs.excel2json.lua_teaching", package.seeall)

local lua_teaching = {}
local fields = {
	detail = 4,
	name = 2,
	bonus = 6,
	battleTag = 5,
	id = 1,
	icon = 7,
	picture = 8,
	tagName = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	detail = 3,
	name = 1,
	tagName = 2
}

function lua_teaching.onLoad(json)
	lua_teaching.configList, lua_teaching.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_teaching
