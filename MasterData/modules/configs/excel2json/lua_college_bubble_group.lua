-- chunkname: @modules/configs/excel2json/lua_college_bubble_group.lua

module("modules.configs.excel2json.lua_college_bubble_group", package.seeall)

local lua_college_bubble_group = {}
local fields = {
	dailyPlayOnce = 4,
	weight = 5,
	type = 3,
	id = 1,
	pos = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_college_bubble_group.onLoad(json)
	lua_college_bubble_group.configList, lua_college_bubble_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_bubble_group
