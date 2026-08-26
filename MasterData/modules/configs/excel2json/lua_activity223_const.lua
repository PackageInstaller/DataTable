-- chunkname: @modules/configs/excel2json/lua_activity223_const.lua

module("modules.configs.excel2json.lua_activity223_const", package.seeall)

local lua_activity223_const = {}
local fields = {
	id = 2,
	value = 3,
	activityId = 1,
	value2 = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity223_const.onLoad(json)
	lua_activity223_const.configList, lua_activity223_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity223_const
