-- chunkname: @modules/configs/excel2json/lua_activity187_blessing.lua

module("modules.configs.excel2json.lua_activity187_blessing", package.seeall)

local lua_activity187_blessing = {}
local fields = {
	lanternImg = 5,
	lanternImgBg = 6,
	blessing = 7,
	lanternRibbon = 4,
	lantern = 3,
	activityId = 1,
	bonus = 2
}
local primaryKey = {
	"activityId",
	"bonus"
}
local mlStringKey = {
	blessing = 1
}

function lua_activity187_blessing.onLoad(json)
	lua_activity187_blessing.configList, lua_activity187_blessing.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity187_blessing
