-- chunkname: @modules/configs/excel2json/lua_stealth_technique.lua

module("modules.configs.excel2json.lua_stealth_technique", package.seeall)

local lua_stealth_technique = {}
local fields = {
	mainTitleId = 2,
	picture = 6,
	subTitle = 5,
	showInMap = 8,
	id = 1,
	mainTitle = 4,
	content = 7,
	subTitleId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 3,
	mainTitle = 1,
	subTitle = 2
}

function lua_stealth_technique.onLoad(json)
	lua_stealth_technique.configList, lua_stealth_technique.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_stealth_technique
