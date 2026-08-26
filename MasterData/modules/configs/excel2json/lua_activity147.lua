-- chunkname: @modules/configs/excel2json/lua_activity147.lua

module("modules.configs.excel2json.lua_activity147", package.seeall)

local lua_activity147 = {}
local fields = {
	jumpId = 6,
	descList = 2,
	spineRes = 4,
	rewardList = 3,
	dialogs = 5,
	activityId = 1
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {
	descList = 1,
	dialogs = 2
}

function lua_activity147.onLoad(json)
	lua_activity147.configList, lua_activity147.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity147
