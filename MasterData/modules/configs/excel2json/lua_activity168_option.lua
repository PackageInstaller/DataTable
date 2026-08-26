-- chunkname: @modules/configs/excel2json/lua_activity168_option.lua

module("modules.configs.excel2json.lua_activity168_option", package.seeall)

local lua_activity168_option = {}
local fields = {
	activityId = 1,
	name = 3,
	costItems = 6,
	effectId = 5,
	mustDrop = 7,
	optionId = 2,
	desc = 4
}
local primaryKey = {
	"activityId",
	"optionId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity168_option.onLoad(json)
	lua_activity168_option.configList, lua_activity168_option.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity168_option
