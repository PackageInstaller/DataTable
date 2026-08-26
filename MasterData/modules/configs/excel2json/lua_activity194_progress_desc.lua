-- chunkname: @modules/configs/excel2json/lua_activity194_progress_desc.lua

module("modules.configs.excel2json.lua_activity194_progress_desc", package.seeall)

local lua_activity194_progress_desc = {}
local fields = {
	roundRange = 5,
	energyRange = 3,
	energyDesc = 4,
	type = 2,
	roundDesc = 6,
	condition = 1
}
local primaryKey = {
	"condition"
}
local mlStringKey = {
	energyDesc = 1,
	roundDesc = 2
}

function lua_activity194_progress_desc.onLoad(json)
	lua_activity194_progress_desc.configList, lua_activity194_progress_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity194_progress_desc
