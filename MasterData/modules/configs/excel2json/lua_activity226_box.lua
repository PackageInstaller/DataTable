-- chunkname: @modules/configs/excel2json/lua_activity226_box.lua

module("modules.configs.excel2json.lua_activity226_box", package.seeall)

local lua_activity226_box = {}
local fields = {
	oneBoxNum = 5,
	bonus = 6,
	showOnlineTime = 2,
	totalBox = 4,
	activityId = 1,
	showOfflineTime = 3
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity226_box.onLoad(json)
	lua_activity226_box.configList, lua_activity226_box.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity226_box
