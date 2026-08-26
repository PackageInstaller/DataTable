-- chunkname: @modules/configs/excel2json/lua_investigate_info.lua

module("modules.configs.excel2json.lua_investigate_info", package.seeall)

local lua_investigate_info = {}
local fields = {
	icon = 6,
	name = 5,
	conclusionDesc = 11,
	conclusionBg = 10,
	group = 3,
	unlockDesc = 7,
	episode = 2,
	desc = 8,
	clueNumber = 9,
	id = 1,
	entrance = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockDesc = 2,
	name = 1,
	conclusionDesc = 4,
	desc = 3
}

function lua_investigate_info.onLoad(json)
	lua_investigate_info.configList, lua_investigate_info.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_investigate_info
