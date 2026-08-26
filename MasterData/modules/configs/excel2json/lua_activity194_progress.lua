-- chunkname: @modules/configs/excel2json/lua_activity194_progress.lua

module("modules.configs.excel2json.lua_activity194_progress", package.seeall)

local lua_activity194_progress = {}
local fields = {
	progressNum = 4,
	progressChange = 3,
	condition = 2,
	optionId = 1
}
local primaryKey = {
	"optionId"
}
local mlStringKey = {}

function lua_activity194_progress.onLoad(json)
	lua_activity194_progress.configList, lua_activity194_progress.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity194_progress
