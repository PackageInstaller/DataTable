-- chunkname: @modules/configs/excel2json/lua_fight_jia_la_bo_na_line.lua

module("modules.configs.excel2json.lua_fight_jia_la_bo_na_line", package.seeall)

local lua_fight_jia_la_bo_na_line = {}
local fields = {
	id = 1,
	lineEffect = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_jia_la_bo_na_line.onLoad(json)
	lua_fight_jia_la_bo_na_line.configList, lua_fight_jia_la_bo_na_line.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_jia_la_bo_na_line
