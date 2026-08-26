-- chunkname: @modules/configs/excel2json/lua_talent_scheme.lua

module("modules.configs.excel2json.lua_talent_scheme", package.seeall)

local lua_talent_scheme = {}
local fields = {
	talentMould = 2,
	starMould = 3,
	talentId = 1,
	talenScheme = 4
}
local primaryKey = {
	"talentId",
	"talentMould",
	"starMould"
}
local mlStringKey = {}

function lua_talent_scheme.onLoad(json)
	lua_talent_scheme.configList, lua_talent_scheme.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_talent_scheme
