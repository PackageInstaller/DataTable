-- chunkname: @modules/configs/excel2json/lua_survival_shelter_invasion.lua

module("modules.configs.excel2json.lua_survival_shelter_invasion", package.seeall)

local lua_survival_shelter_invasion = {}
local fields = {
	id = 1,
	stage = 3,
	round = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_survival_shelter_invasion.onLoad(json)
	lua_survival_shelter_invasion.configList, lua_survival_shelter_invasion.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_shelter_invasion
