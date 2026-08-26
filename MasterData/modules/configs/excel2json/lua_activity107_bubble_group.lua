-- chunkname: @modules/configs/excel2json/lua_activity107_bubble_group.lua

module("modules.configs.excel2json.lua_activity107_bubble_group", package.seeall)

local lua_activity107_bubble_group = {}
local fields = {
	groupId = 1,
	unlockCondition = 4,
	actId = 2,
	resource = 3
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}

function lua_activity107_bubble_group.onLoad(json)
	lua_activity107_bubble_group.configList, lua_activity107_bubble_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity107_bubble_group
