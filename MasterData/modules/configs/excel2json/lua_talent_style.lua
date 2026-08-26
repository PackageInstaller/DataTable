-- chunkname: @modules/configs/excel2json/lua_talent_style.lua

module("modules.configs.excel2json.lua_talent_style", package.seeall)

local lua_talent_style = {}
local fields = {
	replaceCube = 4,
	name = 5,
	tagicon = 6,
	tag = 7,
	talentMould = 1,
	styleId = 2,
	color = 8,
	level = 3
}
local primaryKey = {
	"talentMould",
	"styleId"
}
local mlStringKey = {
	name = 1
}

function lua_talent_style.onLoad(json)
	lua_talent_style.configList, lua_talent_style.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_talent_style
