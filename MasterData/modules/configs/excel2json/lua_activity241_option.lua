-- chunkname: @modules/configs/excel2json/lua_activity241_option.lua

module("modules.configs.excel2json.lua_activity241_option", package.seeall)

local lua_activity241_option = {}
local fields = {
	activityId = 1,
	optionId = 2,
	optionName = 3
}
local primaryKey = {
	"activityId",
	"optionId"
}
local mlStringKey = {}

function lua_activity241_option.onLoad(json)
	lua_activity241_option.configList, lua_activity241_option.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity241_option
