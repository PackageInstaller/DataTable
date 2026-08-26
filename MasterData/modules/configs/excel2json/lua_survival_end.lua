-- chunkname: @modules/configs/excel2json/lua_survival_end.lua

module("modules.configs.excel2json.lua_survival_end", package.seeall)

local lua_survival_end = {}
local fields = {
	endImg = 7,
	name = 2,
	mainImg = 9,
	type = 3,
	group = 4,
	unlock = 6,
	endDesc = 5,
	id = 1,
	order = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	endDesc = 2,
	name = 1
}

function lua_survival_end.onLoad(json)
	lua_survival_end.configList, lua_survival_end.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_end
