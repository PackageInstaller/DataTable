-- chunkname: @modules/configs/excel2json/lua_survival_behavior.lua

module("modules.configs.excel2json.lua_survival_behavior", package.seeall)

local lua_survival_behavior = {}
local fields = {
	chooseEvent = 6,
	priority = 3,
	chooseDesc = 5,
	condition = 2,
	id = 1,
	dialogueId = 4,
	isMark = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	chooseDesc = 1
}

function lua_survival_behavior.onLoad(json)
	lua_survival_behavior.configList, lua_survival_behavior.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_behavior
