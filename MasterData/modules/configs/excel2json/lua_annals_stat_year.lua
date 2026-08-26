-- chunkname: @modules/configs/excel2json/lua_annals_stat_year.lua

module("modules.configs.excel2json.lua_annals_stat_year", package.seeall)

local lua_annals_stat_year = {}
local fields = {
	endTime = 3,
	year = 1,
	startTime = 2
}
local primaryKey = {
	"year"
}
local mlStringKey = {}

function lua_annals_stat_year.onLoad(json)
	lua_annals_stat_year.configList, lua_annals_stat_year.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_annals_stat_year
