-- chunkname: @modules/configs/excel2json/lua_survival_talent.lua

module("modules.configs.excel2json.lua_survival_talent", package.seeall)

local lua_survival_talent = {}
local fields = {
	versions = 3,
	name = 5,
	groupId = 2,
	seasons = 4,
	id = 1,
	desc1 = 6,
	desc2 = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 3,
	name = 1,
	desc1 = 2
}

function lua_survival_talent.onLoad(json)
	lua_survival_talent.configList, lua_survival_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_talent
