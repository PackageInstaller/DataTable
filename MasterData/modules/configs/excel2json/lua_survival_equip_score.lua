-- chunkname: @modules/configs/excel2json/lua_survival_equip_score.lua

module("modules.configs.excel2json.lua_survival_equip_score", package.seeall)

local lua_survival_equip_score = {}
local fields = {
	level = 3,
	worldlevel = 1,
	type = 2
}
local primaryKey = {
	"worldlevel",
	"type"
}
local mlStringKey = {}

function lua_survival_equip_score.onLoad(json)
	lua_survival_equip_score.configList, lua_survival_equip_score.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_equip_score
